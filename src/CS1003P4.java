import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import java.io.File;
import java.io.FileNotFoundException;
import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.ArrayList;
import org.apache.log4j.Logger;
import org.apache.log4j.Level;

/**
 * This is the CS1003P4.java class. It is my submission to the P4 - Gutenberg
 * PLEASE READ THE README.txt FILE FOR GUIDANCE ON RUNNING THE CODE AND THE TESTING
 *
 * @see https://studres.cs.st-andrews.ac.uk/CS1003/Coursework/P4-Gutenberg/P4-Gutenberg.html
 * @author Antoine Megarbane, matriculation number: 220004481
 */
public class CS1003P4 {
    /**
     * A satic main method that calls to the other methods to run the code.
     *
     * @param args The command line arguments
     * @throws IllegalArgumentException If the command line arguments are invalid
     * @throws FileNotFoundException If the inputted directory doesn't exist or is empty
     */
    public static void main(String[] args) {
        try {
            Logger.getRootLogger().setLevel(Level.OFF);
            CS1003P4 engine = new CS1003P4();
            engine.checkValidArguments(args);
            engine.readTextFiles(args[0], args[1], Double.parseDouble(args[2]));
        }
        catch (IllegalArgumentException | FileNotFoundException e) {
            System.out.println(e.getMessage());
        }
    }

    /**
     * This method checks if the command line arguments are valid.
     * If not, it throws an appropriate exception.
     *
     * @param args The command line arguments
     * @throws IllegalArgumentException If the command line arguments are invalid
     * @throws FileNotFoundException If the inputted directory doesn't exist or is empty
     */
    public void checkValidArguments(String[] args) throws IllegalArgumentException, FileNotFoundException {
        if (args.length < 3 || args.length > 3) { // If there are more or less than 3 arguments
            throw new IllegalArgumentException("Invalid number of command line arguments!");
        }
        else {
            File dir = new File(args[0]);
            if (!dir.exists()) { // If the directory doesn't exist
                throw new FileNotFoundException("Directory " + args[0] + " does not exist!");
            }
            else if (dir.list().length == 0) { // If the directory is empty
                throw new FileNotFoundException("Directory " + args[0] + " is empty!");
            }
        }
    }

    /**
     * This method reads the text files in the directory.
     * It uses Spark to read the files and call methods parallely.
     *
     * @param dir The directory containing the text files
     * @param input_query The inputted search term
     * @param index The similarity threshold
     */
    public void readTextFiles(String dir, String input_query, double index) {
        SparkConf conf = new SparkConf().setAppName("CS1003P4").setMaster("local[*]");
        JavaSparkContext jsc = new JavaSparkContext(conf);
        JavaPairRDD<String, String> all_files = jsc.wholeTextFiles(dir); // Read all files in the directory
        all_files.foreach(file -> generateSubsequences(Arrays.asList(file._2().replaceAll("[^a-zA-Z0-9]+", " ").toLowerCase().split("[ \t\n\r]")), input_query, index)); // For each file, format it and generate the subsequences
    }

    /**
     * This method generates the subsequences of a list of words.
     * The size of the subsequences is the same as the size of the user input.
     * This method has to be static in order to be called from the previous method (in all_files.foreach).
     *
     * @param all_words The list containing all of the words stored in the file
     * @param input_query The inputted search term
     * @param index The similarity threshold
     */
    public static void generateSubsequences(List<String> all_words, String input_query, double index) {
        int n = input_query.split(" ").length;
        List<String> subseq_list = new ArrayList<String>();
        for (int i = 0; i<=all_words.size()-n; i++) {
            String subseq = all_words.get(i);
            for (int j = 1; j<n; j++) {
                subseq += " " + all_words.get(i+j);
            }
            subseq_list.add(subseq);
        }
        CS1003P4 engine = new CS1003P4(); // Create a new CS1003P4 object to call non-static methods from a static environment
        engine.getMatchingResults(subseq_list, input_query, index);
    }

    /**
     * This method prints out the subsequences with a Jaccard similarity index equal or higher than the threshold.
     *
     * @param all_subseq The list containing all of the subsequences generated in the previous method
     * @param input_query The inputted search term
     * @param index The similarity threshold
     */
    public void getMatchingResults(List<String> all_subseq, String input_query, double index) {
        for (int i = 0; i<all_subseq.size(); i++) {
            double jaccard = calculateJaccard(calculateBigram(all_subseq.get(i)), calculateBigram(input_query));
            if (jaccard >= index) {
                System.out.println(all_subseq.get(i));
            }
        }
    }

    /**
     * This method generates the character bigram of an inputted word (or sentence).
     * THIS METHOD IS IDENTICAL TO THE ONE IN MY SUBMISSION TO FIRST PRACTICAL (without the top-and-tail).
     *
     * @param word The word that we want to generate a character bigram from
     * @return The character bigram of the word, stored in a HashSet
     */
    public HashSet<String> calculateBigram(String word) {
        HashSet<String> bigram = new HashSet<String>(); // The bigram is a HashSet object, to avoid repeating sequences
        for (int i=0; i<word.length()-1; i++) { // Cycle through every charcater of the inputted word, except the final one
            String a = "" + word.charAt(i);
            String b = "" + word.charAt(i+1);
            String sequence = a+b;
            bigram.add(sequence); // The HashSet automatically checks if the added sequence is already in the bigram
        }
        return bigram;
    }

    /**
     * This method calculates the Jaccard similarity index between two sets of character bigrams.
     * THIS METHOD IS IDENTICAL TO THE ONE IN MY SUBMISSION TO THE FIRST PRACTICAL.
     *
     * @param set1 The first character bigram
     * @param set2 The second character bigram
     * @return The Jaccard similarity index
     */
    public double calculateJaccard(HashSet<String> set1, HashSet<String> set2) {
        HashSet<String> intersection = new HashSet<String>();
        HashSet<String> union = new HashSet<String>();
        if (set1.size() > set2.size()) { // Check which set is the largest
            intersection.addAll(set1);
            intersection.retainAll(set2); // Only keep the elements that are common to both sets
        }
        else {
            intersection.addAll(set2);
            intersection.retainAll(set1);
        }
        set1.addAll(set2); // Set1 being a HashSet, adding all elements of set2 does not create duplicates
        union.addAll(set1); // We do not have to remove the intersection to get the union (c.f. formula |A u B| = |A| + |B| - |A n B|)
        return (double) intersection.size()/union.size();
    }
}
