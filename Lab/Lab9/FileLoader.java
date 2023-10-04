import java.io.File;
import java.io.FilenameFilter;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;


 public class FileLoader {

    /**

     * List out all subdirectories of the specified directory.

     * Use a lambda rather than a FileFilter

     */

    public static void listSubdirectoriesLambda(String dirName) {

        System.out.println("\nList subdirectories, using a lambda: ");

        File dir = new File(dirName);

        File[] subDir = dir.listFiles((file)->{return file.isDirectory();});

        for(File file : subDir) 

            System.out.println(file.getName());

        

        

       

    }

 

    /**

     * List out all subdirectories of the specified directory.

     * For this version, use a method reference.

     */

    public static void listSubdirectoriesMethodRef(String dirName) {

        System.out.println("\nList subdirectories using a method reference");

        File dir = new File(dirName);

        String[] sub = dir.list(new FilenameFilter() {

         @Override

          public boolean accept(File current, String name) {

            return new File(current, name).isDirectory();

          }

        

        });

        for (String file : sub) 

            System.out.println(file);

        

}

 

    /**

     * List out all files in the specified directory that have the specified extension.

     * Use a lambda rather than a FilenameFilter.

     */

    public static void listFiles(String dirName, String extension) {

        System.out.println("\nListing all " + extension + " files");

        File dir = new File(dirName);

        File[] files = dir.listFiles(new FilenameFilter() {

        public boolean accept(File dir, String name) {

                return name.endsWith("." + extension);

            }

        });

        for(File Java : files) 

            System.out.println(Java);

        

    }

 

    public static void main(String[] args) {

        listSubdirectoriesLambda(".");

        listSubdirectoriesMethodRef(".");

        listFiles(".", "java");

    }

 

}