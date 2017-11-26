package _;

//import rhaxe.cmd.Haxe;
//import rhaxe.fs.FileSystem;

@TaskRunner
class Builder {
    @Task
    public function clean() {
        trace("CLEAN");
//        FileSystem.rm("out");
    }

    public function test() {
        trace("TEST");
//        Haxe
//            .classPath("src/main/haxe")
//            .classPath("src/test/haxe")
//            .main("a.b.Main")
//            .dest("out/my_bin");
    }

    @Task("compile:cpp", ["clean"])
    public function compile_cpp() {
        Sys.sleep(1.0);
        trace("COMPILE CPP");
//        Haxe
//            .classPath("src/main/haxe")
//            .main("a.b.Main")
//            .dest("out/my_bin");
    }

    @Task("compile:neko")
    @Depends(["clean"])
    public function compile_neko() {
        trace("COMPILE NEKO");
//        Haxe
//            .classPath("src/main/haxe")
//            .define("IS_C")
//            .define("IS_C_AND", "My_Value")
//            .main("a.b.Main")
//            .dest("out/my_bin");
    }
}