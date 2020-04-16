import java.util.Scanner;

public class Task4 {

	public static void main(String[] args) {
		Scanner input = new Scanner(System.in);
		
		System.out.print("Enter the height of the pyramid: ");
		int height = input.nextInt();
		
		for (int i=1; i < height; i++) {
			for (int j=i; j < height - 1; j++) {
				System.out.print(" ");
			}
			for (int k=0; k < i; k++) {
				System.out.print("*");
			}
			System.out.println("");
		}
	}
}
