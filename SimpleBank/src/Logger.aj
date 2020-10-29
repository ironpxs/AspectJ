import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

public aspect Logger {
	
    
	//UN requerimiento para AMBAS transacciones.
	File file = new File("log.txt");
	
	pointcut transaction() : call(* money*(..) );
    after() : transaction() {
    	
    	Calendar cal = Calendar.getInstance();
        int hora =cal.get(Calendar.HOUR_OF_DAY);
        int minutos = cal.get(Calendar.MINUTE);
        int segundos = cal.get(Calendar.SECOND);
        String metodo = "Realizar transacci�n";
    	try {
    		FileWriter fr = new FileWriter(file,true);
			PrintWriter wr = new PrintWriter(fr);
			if(thisJoinPointStaticPart.getSignature().getName().equalsIgnoreCase("moneyWithdrawal")) {
					metodo = "Retirar dinero";
			}
			wr.append("\nTipo de transacci�n: "+metodo+" Hora->"+ hora + ":" + minutos + ":" + segundos);
			wr.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
    	System.out.println("Tipo de transacci�n: "+metodo+" Hora-> "+ hora + ":" + minutos + ":" + segundos);
    }
    
   //EJEMPLO
   //Requerimiento de creaci�n de usuario
   pointcut success() : call(* create*(..) );
   after() : success() {
       System.out.println("**** User created ****");
   }
        
 
    
}