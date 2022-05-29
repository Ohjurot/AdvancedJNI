#include <Windows.h>

#include <jni.hpp>

#include <string>
#include <iostream>
#include <cassert>
#include <filesystem>

// Native print function that is used by java
void JavaPrint(JNIEnv* env, jobject obj, jstring str)
{
    const char* strx = env->GetStringUTFChars(str, nullptr);
    assert(strx);
    std::cout << "From Java: " << strx << std::endl;
    env->ReleaseStringUTFChars(str, strx);
}

// Here we create own own JVM class
// This is required for setting up the vm and optionaly registering  I/O hooks
class MyJVM : public jni::JavaVM
{
protected:
    // This function will be called when the VM is starting. Here you need to provide all vm settings and the classpath
    void SetupVM(jni::VMArguments& Args) override
    {
        Args.SetJNIVersion(JNI_VERSION_10);
        Args.IgnoreUnrecognized(false);
        Args.AddClasspathJarFolder(std::filesystem::current_path() / "java");
    }
};

// Applications main entry point
int main(int argc, char** argv)
{
    // Delay Load the JVM DLL now
    std::filesystem::path JvmDllPath = std::filesystem::current_path() / "jre" / "bin" / "server" / "jvm.dll";
    HMODULE jvmLib = LoadLibraryW(JvmDllPath.wstring().c_str());

    // Create an instance of the custom java vm and start it
    MyJVM vm;
    if (vm.StartVM())
    {
        
        // Register native function
        jclass ConsoleClass = vm->FindClass("com/my/lib/Console");
        assert(ConsoleClass);
        JNINativeMethod ConsolePrintClass;
        ConsolePrintClass.fnPtr = &JavaPrint;
        ConsolePrintClass.name = (char*)"Print";
        ConsolePrintClass.signature = (char*)"(Ljava/lang/String;)V";
        jint RegisterNativeResult = vm->RegisterNatives(ConsoleClass, &ConsolePrintClass, 1);
        assert(RegisterNativeResult == JNI_OK);

        // Find main function 
        jclass MainClass = vm->FindClass("com/my/code/Plugin");
        assert(MainClass);
        jmethodID MainMeth = vm->GetStaticMethodID(MainClass, "Main", "()V");
        assert(MainMeth);

        // Call the main function
        vm->CallStaticVoidMethod(MainClass, MainMeth);
        
        // We are done. Now stop the vm
        vm.StopVM();
    }

    return 0;
}
