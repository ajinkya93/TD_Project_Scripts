/*
Java program to get commit IDs from the output produced by git log
*/
import java.io.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

class GetCommitID{

public static void getCommitIDFromLog(String filename) throws Exception{
	BufferedReader reader = null;

	//Name of the file(processed) to which the output would be written
	  File file = new File("commit_IDs_from_instances_from_keyword_"+filename+".txt");

	//Create the output file if it does not exist
	if (!file.exists()){
		file.createNewFile();
	}//end-if

	FileWriter fw = new FileWriter(file.getAbsoluteFile());
	BufferedWriter bw = new BufferedWriter(fw);
	
	try{
		reader = new BufferedReader(new FileReader(new File(filename)));
		String strLine;
		while ((strLine = reader.readLine()) != null){
			int line_length = strLine.length();
			Pattern p = Pattern.compile("^commit");
			Matcher m = p.matcher(strLine);
			
			if(m.find()){
						String commit_id = strLine.substring(m.end()+1);
    					 	bw.write(commit_id+"\n");
				}//end-nested-if
			}//end-while
	}catch (FileNotFoundException e) {
		//Print the stack trace in case of exception
    		e.printStackTrace();
	}
	finally{
		//Close the file reading and writing handles
		reader.close();	
		bw.close();
	}
}

public static void main(String args[]) throws Exception{

if((args.length < 1)) {
        System.out.println("Incorrect number of arguments supplied.");
		System.out.println("*****USAGE*****");
		System.out.println("java [executable] [input-log-file]");
        System.exit(1);
        }
else{
	//Pass the file to be processed as the argument
	getCommitIDFromLog(args[0]);
}
	}
}
