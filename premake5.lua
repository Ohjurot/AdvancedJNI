-- Premake 5 LUA Script
-- This is your default premake + conan script
-- Modifiy it by your needs

-- Include conan gennerate script
include("conanbuildinfo.premake.lua")

-- Project workspace
workspace "JavaTest"
    -- Import conan gennerate config
    conan_basic_setup()    

    -- Project
    project "JavaHost"
        -- Basic setup
        kind "ConsoleApp"
        language "C++"
        cppdialect "C++20"
        targetdir "bin/%{cfg.buildcfg}"
        objdir "bin/%{cfg.buildcfg}/obj/"
        location "src/JavaHost"
        debugdir "%{wks.location}/app"

        -- Source files
        files { "%{prj.location}/**.h", "%{prj.location}/**.cpp" }

        -- Enable delay loading
        links { "delayimp.lib" }

        -- Include java
        includedirs { 
            "%{wks.location}/jdk/include", 
            "%{wks.location}/jdk/include/win32" 
        }
        libdirs{
            "%{wks.location}/jdk/lib"
        }
        links { "jvm.lib" }
        linkoptions {"/DELAYLOAD:\"jvm.dll\""}

        -- C++ Defines
        filter "configurations:Debug"
            defines { "DEBUG"}
            symbols "On"
        filter ""
        filter "configurations:Release"
            defines { "NDEBUG" }
            optimize "On"
        filter ""
