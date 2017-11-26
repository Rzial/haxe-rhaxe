package rhaxe.logger;

class Console {
    public static inline function Log(message: Dynamic) {
        Sys.println(message);
    }

    public static inline function TimeLog(message: Dynamic) {
        Console.Log('[${DateTools.format(Date.now(), "%H:%M:%S")}] ${message}');
    }

    public static inline function Fatal(message: Dynamic) {
        Console.Log('[FATAL] ${message}');
    }

    public static inline function Error(message: Dynamic) {
        Console.Log('[ERROR] ${message}');
    }

    public static inline function Warn(message: Dynamic) {
        Console.Log('[WARNING] ${message}');
    }

    public static inline function Debug(message: Dynamic) {
        Console.Log('[DEBUG] ${message}');
    }

    public static inline function Trace(message: Dynamic) {
        Console.Log('[TRACE] ${message}');
    }

    public static inline function Info(message: Dynamic) {
        Console.Log('[INFO] ${message}');
    }
}