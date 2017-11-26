package _;

//import rhaxe.cmd.Haxe;
//import rhaxe.fs.FileSystem;

@TaskRunner
class TaskRunner {
    @Task
    public function clean() {
//        FileSystem.rm("out");
    }

    @Task
    public function test() {
//        Haxe
//            .classPath("src/main/haxe")
//            .classPath("src/test/haxe")
//            .main("a.b.Main")
//            .dest("out/my_bin");
    }

    @Task("compile", ["clean"])
    public function compile_cpp() {
//        Haxe
//            .classPath("src/main/haxe")
//            .main("a.b.Main")
//            .dest("out/my_bin");
    }

    @Task("compile")
    @Depends(["clean"])
    public function compile_neko() {
//        Haxe
//            .classPath("src/main/haxe")
//            .define("IS_C")
//            .define("IS_C_AND", "My_Value")
//            .main("a.b.Main")
//            .dest("out/my_bin");
    }
}