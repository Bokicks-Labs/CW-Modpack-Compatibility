import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.nio.file.Files;
import java.nio.file.Path;

/** Runs one sandbox-options file through the parser in projectzomboid.jar. */
public final class VerifySandboxOptions {
    private VerifySandboxOptions() {
    }

    public static void main(String[] args) throws Exception {
        if (args.length != 1) {
            System.err.println("usage: VerifySandboxOptions.java <sandbox-options.txt>");
            System.exit(2);
        }

        Path target = Path.of(args[0]).toAbsolutePath().normalize();
        Class<?> parserType = Class.forName("zombie.sandbox.CustomSandboxOptions");
        Object parser = parserType.getConstructor().newInstance();
        Method parse = parserType.getDeclaredMethod("parse", String.class);
        parse.setAccessible(true);

        try {
            parse.invoke(parser, Files.readString(target));
        } catch (InvocationTargetException error) {
            Throwable cause = error.getCause();
            System.err.println("FAIL: " + target);
            System.err.println(cause == null ? error : cause);
            System.exit(1);
        }

        System.out.println("PASS: " + target);
    }
}
