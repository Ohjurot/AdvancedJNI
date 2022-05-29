# Conan, Premake5, JNI - C++ Template
This template allows you to start developing C++ applications that can be extended (scripting) with Java using JNI. 

## Platform support
Currently only Windows. But it is possible to run on other systems by implementing custom scripts

## Requirments
- Premake5 compatible IDE (Currently only works for MSVC compiler and linker! Autogen script only allows VisualStudio projects)
- C++20
- CMake (When using conan to get libraries that need to be compiled on your system)
- Conan
- Python (For conan)
- Eclipse (As a java IDE, any other IDE also usable)

## Instructions
1. **Setting up the build environment** 
Run the command `devenv` from the root directory to download and setup the local development environment (JDK, JRE, ...; This will only affect the current directory). You will only need to run this once! THIS WILL BE REQUIRED FOR ALL FURTHER DEVELOPMENT STEPS
2. **Generating the project files**
Run the command `autogen` from the root directory to generate the visual studio solution. To get a debug build run `autogen debug`. You will now file the solution file in your root directory. You can open the solution for editing or use `build` to build the solution.
3. **Building the solution** 
Run the command `build` from the root directory to build the project in Release configuration. A previous call to `autogen` is NOT required.
(THIS WILL ONLY WORK FROM A DEVELOPER COMMAND PROMPT)
4. **Deploying the project to a ZIP** 
Run the command `deploy` to pack all the generate binaries, jre and other contents from the app directory to a single (portable) zip file. 
