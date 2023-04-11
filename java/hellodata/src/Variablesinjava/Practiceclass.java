package Variablesinjava;


public class Practiceclass {

    int k;  //  instance variable holds default value
     String str;
    // instance variable or global variable

    public void method1() {

        int j = 9; //doesnt hold default variable
        //local variable
        System.out.println(j);


    }

    public static void main(String[] args) {

        Practiceclass obj = new Practiceclass();//call instance variable

        System.out.println(obj.k);// output of instance variable
        System.out.println(obj.str);
        obj.method1();

    }
} //instance variable can have default value but local variable cannot have
//instance variable are accessible any where in the class but local variable within the method only
// we cannot reinitialize for global variable but possible for local variable
// every object of class have thier own copy of instance variable value