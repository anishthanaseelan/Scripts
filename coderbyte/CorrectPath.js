function ChessboardTraveling(str) {
    let arr = str.match(/\d/g);
    let xy = arr[0].toString()+arr[1].toString();
    let ab = arr[2].toString()+arr[3].toString();
    let boardMap = new Map();

    function boxFactory(maxX , maxY){
        function createBox(x,y){
            if ( x < 1 || y < 1 ) {return undefined;}
            let id = x.toString() + y.toString();
            
            if ( !boardMap.has(id) && x<= maxX && y <= maxY){
                console.log(x + ":" + y);
                boardMap.set(id ,  {
                    id: id,
                    x:  x,
                    y:  y,
                    boxUp: createBox(x+1 , y),
                    boxDown: createBox(x-1 , y),
                    boxRight: createBox(x , y+1),
                    boxLeft: createBox(x , y-1),
                    isVisited : false
                });
            }
            return boardMap.get(id); 
        }
        createBox(1,1);
    }

    function traverseBoard(xy,ab){
        let visitCount = 0;
        function visitBox(xy){
            console.log("Visiting " + xy );
            if ( !boardMap.has(xy) ) { return; }

            if (xy == ab) { 
                //console.log("Destination reached!");
                visitCount++;
                return true;
            }
            
            let box = boardMap.get(xy);
            box.isVisited = true;
            
            if ( box.boxUp != undefined ){
                visitBox(box.boxUp.id);
            } 
            if ( box.boxRight != undefined ){
                visitBox(box.boxRight.id);
            }

        }  
        visitBox(xy);
        return visitCount;
    }
    boxFactory(5,5); 
    console.log(traverseBoard('11','55'));
    //return (traverseBoard(xy,ab));
}
console.log(ChessboardTraveling('(1 1)(5 5)'));
/*

Input:"???rrurdr?"

Output:"dddrrurdrd"


Input:"drdr??rrddd?"

Output:"drdruurrdddd"
*/