function matching()
{
    let str = "==a+";
    let arr = str.match( /\+[a-z]\+/ig );
    if ( arr.length == 0 ) {
        return false;
    }   else {   
        return (str.match( /\+[a-z]\+/ig ).length ==  str.match ( /[a-z]/ig).length);
    }
}

console.log(matching());