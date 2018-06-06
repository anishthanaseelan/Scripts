function CorrectPath(str) {
    const matrixSize = { x: 5, y: 5 };
    let currentCell = { x: 0, y: 0 };

    moveRight = (i) => {
        if (matrixSize.x > (currentCell.x + 1)) {
            currentCell.x += 1;
            traverse(i + 1);
        } else {
            console.log("Incorrect Path - Right")
        }
    };
    moveLeft = (i) => {
        if (matrixSize.x > (currentCell.x - 1)) {
            currentCell.x -= 1;
            traverse(i + 1);
        } else {
            console.log("Incorrect Path - left")
        }
    };

    moveDown = (i) => {
        if (matrixSize.y > (currentCell.y + 1)) {
            currentCell.y += 1;
            traverse(i + 1);
        } else {
            console.log("Incorrect Path - Down")
        }
    };
    moveUp = (i) => {
        if (0 <= (currentCell.y - 1)) {
            currentCell.y -= 1;
            traverse(i + 1);
        } else {
            console.log("Incorrect Path - Up")
        }
    };


    function traverse(i) {

        if ( i >= str.length) { 
            console.log( currentCell.x + ":" + currentCell.y);
            return 
        }
        console.log(str[i]);        
        switch (str[i]) {
            case 'r':
                moveRight(i);
                break;
            case 'l':
                moveLeft(i);
                break;
            case 'u':
                moveUp(i);
                break;
            case 'd':
                moveDown(i);
                break;
            case '?':
                moveRight(i);
                moveLeft(i);
                moveUp(i);
                moveDown(i);
            default:
                console.log('Dont know what to do with ' + str[i]);
        }
    }
    traverse(0);
}

CorrectPath("dd?rrurdrd");
/*

Input:"???rrurdr?"

Output:"dddrrurdrd"

Input:"drdr??rrddd?"

Output:"drdruurrdddd"
*/