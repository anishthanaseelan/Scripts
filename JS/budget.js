const BANK_BALANCE = 1000;
const PHONE_SPENDING_LIMIT = 500;
var currentSpending = 0;

while (currentSpending < BANK_BALANCE){
	var choice = prompt("What you want to buy, Phone or Accessory");
	if (  choice == "Phone" ){
		buyPhone();
	}else if (choice == "Accessory" ){
		buyAccessory();
	}else{
		alert ( "Bye Then!");
		break;
	}
}

function buyPhone(){
	var price = Number(prompt("Phone Price"));
	alert ( "Actual Cost is " + actualCost(price) );
	if ( isWithinLimit(actualCost(price) ) ){
		if (doIHaveBalance(actualCost(price))){
				purchase(price);
		}else{
			alert("You don't have enough balance to buy that, Consider buying some other");
		}
	}else{
		alert("That will Exceed your Limit!, Consider buying some other");
	}
	return;
}

function purchase(price){
	currentSpending += actualCost(price);
	alert("Purchase Completed for" +  actualCost(price) + "and " + (BANK_BALANCE - currentSpending) + " left to spend");
	return;
}

function actualCost(price){
	return (price + calculateTax ( price ));
}

function calculateTax(price){
	return price * 0.2 ;
}
function buyAccessory(){
	var price = Number(prompt ("Accessory  Price"));
	if (doIHaveBalance (actualCost(price))){
		purchase(price);		
	}else{
		alert("You don't have enough balance to buy that, Consider buying something else");
	}
	return;
}

function doIHaveBalance(price){
	if ( ( currentSpending + price ) <= BANK_BALANCE ){
		return true;
	}
	return false;
}

function isWithinLimit(price){
	if ( price <= PHONE_SPENDING_LIMIT ){
		alert ( "Purchase approved");
		return true;
	}
	return false;
}