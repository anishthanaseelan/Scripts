let maxX = 5;
let maxY = 5;

function IsitmyFamily(id, parent) {
    //console.log( id, parent);
    if (parent === undefined) {
        return false;
    } else if (id == '11') {
        return true;
    } else if (id == parent.id) {
        return true;
    } else if (parent.id == '11') {
        return false;
    }
    return (IsitmyFamily(id, parent.parent));
}

function isMax(X, Y) {
    if (X > maxX || Y > maxY || X < 1 || Y < 1) {
        // console.log('Reahed Boundry' + X+''+Y) ;
        return true;
    }
}

function buildPathsTree(X, Y, parent) {
    if (isMax(X, Y)) { return undefined };
    if (IsitmyFamily(X + '' + Y, parent)) { return undefined };
    console.log(X + '' + Y);
    return (new Node(X, Y, parent));
}

function Node(X, Y, parent) {
    this.id = X + '' + Y;
    this.parent = parent;
    //console.log('ID: ' + this );
    if (!(X == maxX && Y == maxY)) {
        this.left = buildPathsTree(X - 1, Y, this);
        this.right = buildPathsTree(X + 1, Y, this);
        this.up = buildPathsTree(X, Y - 1, this);
        this.down = buildPathsTree(X, Y + 1, this);
    }
}

let root = buildPathsTree(1, 1, undefined);
console.log(root);

/*

Input:"???rrurdr?"

Output:"dddrrurdrd"


Input:"drdr??rrddd?"

Output:"drdruurrdddd"
*/
