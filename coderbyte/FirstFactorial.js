function FirstFactorial(num) { 
    let sum =1;
    for ( i=num;i>0;i--){
        sum = sum *i;
    }
  return sum;         
  }
     
  // keep this function call here 

  console.log(FirstFactorial(2));