function KaprekarsConstant(num) { 
    let count = 0;

    function make4Digit(num){
        if ( num > 999){
            return num;
        } else if ( num > 100 ){
            return '0'+num;
        } else {
            return '00' + num;
        }
    }
    function compareDesc ( a , b){
        return a-b ;
    }
    function compareAsc ( a , b){
        return b-a ;
    }     
    function recu(num){
        num = make4Digit(num);
        num1 =  num.toString().split('').sort(compareDesc).join('');
        num2 =  num.toString().split('').sort(compareAsc).join('');
        //console.log( num1 + "," + num2);
        if ( num1 > num2 ){
            num = num1 - num2;
        } else {
            num = num2 - num1;
        }
        return num;
    }
      //console.log(recu(134));
    while ( true ){
        count++;
        num = recu(num);
        if ( num ==  6174 || count > 10 ){
            break;
        } 
    }
    return count; 
            
}
       
    // keep this function call here 
console.log(KaprekarsConstant(9831 ));                            
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
                                
                                
                                
      