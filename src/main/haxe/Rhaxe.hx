package;

import rhaxe.logger.Console;

class Rhaxe {
    private static inline var VERSION = "1.0.0rc";

    private static var RHAXE_CWD = "";
    private static var RHAXE_JSON = "rhaxe.json";

    // TODO: this
    private static function processArguments(arguments: Array<String>) : Array<String> {
        RHAXE_CWD = arguments.pop();
        arguments.reverse();

        //TODO: Process flags

        //TODO: Get task list
//        trace(arguments);
        return [];
    }

    public static function main() {
        var taskList = processArguments(Sys.args());

        for (task in taskList) {}

//        var sampleTaskRunner = "../../../builder/Builder";
//        trace(sampleTaskRunner);

//        var string = Type.createEmptyInstance(Type.resolveClass("Rhaxe"));
//        Type.createInstance(myClass, []);

//        trace(Type.resolveClass("Builder"));
//        trace(string);

        compileTaskRunner();
        launchTaskRunner();
        cleanTaskRunner();
    }

    private static function compileTaskRunner() {
        // TODO: Get parameters from rhaxe.json
        var cmdResult = Sys.command("haxe", [
            "-cp"  , "rhaxe",
            "-lib" , "rhaxe",
            "-main", "rhaxe.runtime.Runner",
            "-neko", ".rhaxe/task_runner.n",
            "--macro", "include('_')"
        ]);

        if (cmdResult != 0) {
            Sys.exit(1);
        }
    }

    private static function launchTaskRunner() {
        Console.Log('>> Rhaxe v${VERSION} (Haxe Runner)');
        Console.TimeLog('Using rhaxe configuration \'${RHAXE_JSON}\'');

        var cmdResult = Sys.command("neko", [
            ".rhaxe/task_runner.n",
            "Builder"
        ]);
    }

    private static function cleanTaskRunner() {
        // TODO: Get parameters from rhaxe.json
        // TODO: Make it true cross platform
        var cmdResult = Sys.command("rm", [
            "-rf", ".rhaxe"
        ]);

        if (cmdResult != 0) {
            Sys.exit(1);
        }
    }
}