function matching()
{
    let str = "A";
    let arr = str.split('');
    console.log(arr);
    for ( let i = 0 ; i < arr.length; i++ ){
        if ( arr[i].match(/^[a-z]$/i) != undefined  ){
            if ( arr[i-1] == "+" && arr[i+1] == "+" ){
                // Defer till the end return true;
            }else{
                return false;
            }
        }
    }
    return true;
}

console.log(matching());

