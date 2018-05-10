function PentagonalNumber(num){
    let count = 1;
    if ( num == 1 ){ return count;}
    for ( i = 2 ; i<= num; i++ ){
        count += ( (i-1)*5); 
    }
    return count;
} 

console.log(PentagonalNumber(4));

