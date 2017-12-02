include "lzma"

project "ygopro"
    kind "WindowedApp"

    files { "**.cpp", "**.cc", "**.c", "**.h" }
    excludes "lzma/**"
    includedirs { "../ocgcore" }
    links { "ocgcore", "clzma", "Irrlicht", "freetype", "sqlite3", "lua" , "event" }
    if USE_IRRKLANG then
        defines { "YGOPRO_USE_IRRKLANG" }
        links { "irrKlang" }
        if USE_IKPMP3 then
		    links { "ikpMP3" }
            defines { "YGOPRO_USE_IKPMP3" }
        end
        if IRRKLANG_PRO then
            defines { "IRRKLANG_STATIC" }
        end
    end

    configuration "windows"
        files "ygopro.rc"
        excludes "CGUIButton.cpp"
        includedirs { "../irrlicht/include", "../freetype/include", "../event/include", "../sqlite3" }
        if USE_IRRKLANG then
            includedirs { "../irrklang/include" }
            libdirs { "../irrklang/lib/Win32-visualStudio" }
        end
        links { "opengl32", "ws2_32", "winmm", "gdi32", "kernel32", "user32", "imm32" }
    configuration {"windows", "not vs*"}
        includedirs { "/mingw/include/irrlicht", "/mingw/include/freetype2" }
    configuration "not vs*"
        buildoptions { "-std=gnu++0x", "-fno-rtti" }
    configuration "not windows"
        includedirs { "/usr/include/lua", "/usr/include/lua5.3", "/usr/include/lua/5.3", "/usr/include/irrlicht", "/usr/include/freetype2" }
        excludes { "COSOperator.*" }
        links { "event_pthreads", "GL", "dl", "pthread" }
