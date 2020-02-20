import java.util.Scanner;

public class Unicode {

	public static void main(String[] args) {
		
		Scanner input = new Scanner(System.in);
		
		System.out.println("Let's convert numbers to the ASCII characters!");
		System.out.println("From: ");
		String number1 = input.nextLine();
		
		System.out.println("To: ");
		String number2 = input.nextLine();
		
		int first = Integer.parseInt(number1);
		int second = Integer.parseInt(number2);
		
		for(int i=first; i < second; i++) {
			System.out.printf("The ASCII" + "(%d)" + " character is: " + (char)i + ".\n", i);
		}		
	}

}
