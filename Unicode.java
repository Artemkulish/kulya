import java.util.Scanner;

public class Unicode {

	public static void main(String[] args) {
		
		Scanner input = new Scanner(System.in);
		
		System.out.println("Let's convert some numbers to the ASCII characters!");
		System.out.print("From: ");
		int number1 = input.nextInt();
		
		System.out.print("To: ");
		int number2 = input.nextInt();
		
		for (int i=number1; i < number2; i++) {
			System.out.printf("The ASCII" + "(%d)" + " character is: " + (char)i + ".\n", i);
		}		
	}

}
