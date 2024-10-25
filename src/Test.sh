# !/bin/sh
# Testing for CS1003P4.java
export CLASSPATH=${CLASSPATH}:"/cs/studres/CS1003/0-General/spark/*":.
rm -f *.class
javac *.java

# Compulsory tests found in the Tests/queries directory
touch stdout.txt
touch diff.txt

echo -e -n "Testing for 'she generally gave herself very good advice though she very seldom followed it' with a similarity threshold of 0.95: "
java --add-exports java.base/sun.nio.ch=ALL-UNNAMED CS1003P4 "/cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/data" "she generally gave herself very good advice though she very seldom followed it" 0.95 > ./stdout.txt
LC_ALL=C sort ./stdout.txt -o ./stdout.txt
diff ./stdout.txt /cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/queries/advice/expected.txt | echo > diff.txt
sed -i '/^\s*$/d' diff.txt
if [ -s diff.txt ]; then
	echo "Fail!"
	diff -y ./stdout.txt /cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/queries/advice/expected.txt
else
	echo "Pass!"
fi

echo -e -n "\nTesting for 'to be or not to be' with a similarity threshold of 0.75: "
java --add-exports java.base/sun.nio.ch=ALL-UNNAMED CS1003P4 "/cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/data" "to be or not to be" 0.75 > ./stdout.txt
LC_ALL=C sort ./stdout.txt -o ./stdout.txt
diff ./stdout.txt /cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/queries/not-found/expected.txt | echo > diff.txt
sed -i '/^\s*$/d' diff.txt
if [ -s diff.txt ]; then
	echo "Fail!"
	diff -y ./stdout.txt /cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/queries/not-found/expected.txt
else
	echo "Pass!"
fi

echo -e -n "\nTesting for 'setting sail to the rising wind' with a similarity threshold of 0.75: "
java --add-exports java.base/sun.nio.ch=ALL-UNNAMED CS1003P4 "/cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/data" "setting sail to the rising wind" 0.75 > ./stdout.txt
LC_ALL=C sort ./stdout.txt -o ./stdout.txt
diff ./stdout.txt /cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/queries/sail/expected.txt | echo > diff.txt
sed -i '/^\s*$/d' diff.txt
if [ -s diff.txt ]; then
	echo "Fail!"
	diff -y ./stdout.txt /cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/queries/sail/expected.txt
else
	echo "Pass!"
fi

echo -e -n "\nTesting for 'hide the christmas tree carefully' with a similarity threshold of 0.75: "
java --add-exports java.base/sun.nio.ch=ALL-UNNAMED CS1003P4 "/cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/data" "hide the christmas tree carefully" 0.75 > ./stdout.txt
LC_ALL=C sort ./stdout.txt -o ./stdout.txt
diff ./stdout.txt /cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/queries/tree/expected.txt | echo > diff.txt
sed -i '/^\s*$/d' diff.txt
if [ -s diff.txt ]; then
	echo "Fail!"
	diff -y ./stdout.txt /cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/queries/tree/expected.txt
else
	echo "Pass!"
fi

echo -e -n "\nTesting for 'what sort of madness is this' with a similarity threshold of 0.50: "
java --add-exports java.base/sun.nio.ch=ALL-UNNAMED CS1003P4 "/cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/data" "what sort of madness is this" 0.50 > ./stdout.txt
LC_ALL=C sort ./stdout.txt -o ./stdout.txt
diff ./stdout.txt /cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/queries/what-50/expected.txt | echo > diff.txt
sed -i '/^\s*$/d' diff.txt
if [ -s diff.txt ]; then
	echo "Fail!"
	diff -y ./stdout.txt /cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/queries/what-50/expected.txt
else
	echo "Pass!"
fi

echo -e -n "\nTesting for 'what sort of madness is this' with a similarity threshold of 0.62: "
java --add-exports java.base/sun.nio.ch=ALL-UNNAMED CS1003P4 "/cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/data" "what sort of madness is this" 0.62 > ./stdout.txt
LC_ALL=C sort ./stdout.txt -o ./stdout.txt
diff ./stdout.txt /cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/queries/what-62/expected.txt | echo > diff.txt
sed -i '/^\s*$/d' diff.txt
if [ -s diff.txt ]; then
	echo "Fail!"
	diff -y ./stdout.txt /cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/queries/what-62/expected.txt
else
	echo "Pass!"
fi

echo -e -n "\nTesting for 'what sort of madness is this' with a similarity threshold of 0.75: "
java --add-exports java.base/sun.nio.ch=ALL-UNNAMED CS1003P4 "/cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/data" "what sort of madness is this" 0.75 > ./stdout.txt
LC_ALL=C sort ./stdout.txt -o ./stdout.txt
diff ./stdout.txt /cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/queries/what-75/expected.txt | echo > diff.txt
sed -i '/^\s*$/d' diff.txt
if [ -s diff.txt ]; then
	echo "Fail!"
	diff -y ./stdout.txt /cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/queries/what-75/expected.txt
else
	echo "Pass!"
fi

# Non-compulsory tests: testing the exception handling
echo -e -n "\nTesting for invalid number of command line arguments: "
java --add-exports java.base/sun.nio.ch=ALL-UNNAMED CS1003P4 "/cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/data" "she generally gave herself very good advice though she very seldom followed it" > ./stdout.txt
LC_ALL=C sort ./stdout.txt -o ./stdout.txt
diff ./stdout.txt ../Expected/invalid.txt | echo > diff.txt
sed -i '/^\s*$/d' diff.txt
if [ -s diff.txt ]; then
	echo "Fail!"
	diff -y ./stdout.txt ../Expected/invalid.txt
else
	echo "Pass!"
fi

echo -e -n "\nTesting for non-existing directory: "
java --add-exports java.base/sun.nio.ch=ALL-UNNAMED CS1003P4 "Directory" "she generally gave herself very good advice though she very seldom followed it" 0.95 > ./stdout.txt
LC_ALL=C sort ./stdout.txt -o ./stdout.txt
diff ./stdout.txt ../Expected/non-existing.txt | echo > diff.txt
sed -i '/^\s*$/d' diff.txt
if [ -s diff.txt ]; then
	echo "Fail!"
	diff -y ./stdout.txt ../Expected/non-existing.txt
else
	echo "Pass!"
fi

echo -e -n "\nTesting for empty directory: "
mkdir Empty
java --add-exports java.base/sun.nio.ch=ALL-UNNAMED CS1003P4 "Empty" "she generally gave herself very good advice though she very seldom followed it" 0.95 > stdout.txt
rm -r Empty
LC_ALL=C sort ./stdout.txt -o ./stdout.txt
diff ./stdout.txt ../Expected/empty.txt | echo > diff.txt
sed -i '/^\s*$/d' diff.txt
if [ -s diff.txt ]; then
	echo "Fail!"
	diff -y ./stdout.txt ../Expected/empty.txt
else
	echo "Pass!"
fi

rm -f stdout.txt
rm -f diff.txt
