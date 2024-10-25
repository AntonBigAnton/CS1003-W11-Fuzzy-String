TO RUN THE CODE BY ITSELF:
>> cd src
>> export CLASSPATH=${CLASSPATH}:"/cs/studres/CS1003/0-General/spark/*":.
>> javac *.java
>> java --add-exports java.base/sun.nio.ch=ALL-UNNAMED CS1003P4 "/cs/studres/CS1003/Coursework/P4-Gutenberg/Tests/data" "SEARCH TERM" SIMILARITY

TO RUN THE TESTING:
>> cd src
>> chmod 755 Test.sh
>> ./Test.sh
Testing for 'she generally gave herself very good advice though she very seldom followed it' with a similarity threshold of 0.95: Pass!

Testing for 'to be or not to be' with a similarity threshold of 0.75: Pass!

Testing for 'setting sail to the rising wind' with a similarity threshold of 0.75: Pass!

Testing for 'hide the christmas tree carefully' with a similarity threshold of 0.75: Pass!

Testing for 'what sort of madness is this' with a similarity threshold of 0.50: Pass!

Testing for 'what sort of madness is this' with a similarity threshold of 0.62: Pass!

Testing for 'what sort of madness is this' with a similarity threshold of 0.75: Pass!

Testing for invalid number of command line arguments: Pass!

Testing for non-existing directory: Pass!

Testing for empty directory: Pass!