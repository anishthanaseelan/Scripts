function TimeConvert (num){
    let min = num%60;
    let hour = (num-min)/60;
    return ( hour + ":" + min);
}

console.log(TimeConvert(61));
