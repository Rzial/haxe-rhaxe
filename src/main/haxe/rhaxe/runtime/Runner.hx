package rhaxe.runtime;

import haxe.rtti.Meta;
import haxe.DynamicAccess;
import haxe.Timer;
import rhaxe.logger.Console;

// TODO: Read @TaskRunner
private typedef MetaClass = String;
private typedef MetaMethodList = DynamicAccess<DynamicAccess<Array<Dynamic>>>;

private typedef TaskInfo = {
    runner: Dynamic,
    method: String,
    depends: Array<String>
}

// TODO: Make the runner detect callback parameter on task to parallelize
// TODO: Create a task dependency tree
class Runner {
    // TODO: Implement TaskRunners (not needed to extend this map, task must be unique)
    private static var tasks : Map<String, TaskInfo> = new Map();

    private static function addTask(runner: Class<Dynamic>, method: String, name: String, depends: Array<String>) {
        if (!tasks.exists(name)) {
            tasks.set(name, {
                runner: Type.createEmptyInstance(runner),
                method: method,
                depends: depends
            });
        }
        else {
            rhaxe.logger.Console.Fatal('${runner}:${method} | @Task "${name}" already defined.');
            Sys.exit(1);
        }
    }

    private static function setupTaskRunner(taskRunner: Class<Dynamic>) {
        var runnerName = Type.getClassName(taskRunner);
        var methods : MetaMethodList = cast Meta.getFields(taskRunner);

        for (method in methods.keys()) {
            var methodMetas = methods.get(method);
            if (methodMetas.exists("Task")) {
                var taskMeta = methodMetas.get("Task");
                var taskName : String = (taskMeta == null)? method : taskMeta[0];

                var taskDependencies = methodMetas.get("Depends");
                taskDependencies = (taskDependencies != null)? taskDependencies[0] : null;

                if (taskMeta != null && taskMeta.length == 2) {
                    if (taskDependencies == null) {
                        taskDependencies = taskMeta[1];

                    }
                    else {
                        rhaxe.logger.Console.Fatal('${runnerName}:${method} | @Depends cannot be used if dependencies are already defined on @Task.');
                        Sys.exit(1);
                    }
                }

                addTask(taskRunner, cast method, cast taskName, cast taskDependencies);
            }
        }
    }

    private static function runTaskList(taskList: Array<String>) {
        for (taskName in taskList) {
            var task : TaskInfo = tasks[taskName];
            if (task != null) {
                if (task.depends != null) {
                    runTaskList(task.depends);
                }

                Console.TimeLog('Starting \'${taskName}\' ...');
                var startTime = Timer.stamp();
                Reflect.callMethod(task.runner, Reflect.field(task.runner, task.method), []);
                var endTime = Timer.stamp();
                Console.TimeLog('Finished \'${taskName}\' after ${Std.int((endTime - startTime) * 1000)}ms');
            }
            else {
                rhaxe.logger.Console.Fatal('Undefined task "${taskName}".');
                Sys.exit(1);
            }
        }
    }

    public static function main() {
        // TODO: Get the task runner class as argument
        // TODO: Get the task list as argument
        var taskRunner = Type.resolveClass("_.Builder");
        var taskList = ['compile:cpp'];

        setupTaskRunner(taskRunner);
        runTaskList(taskList);
    }
}