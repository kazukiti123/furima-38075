function culc(){
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
  const itemPriceNum = document.getElementById("item-price").value;
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  const addTaxPriceNum = Math.trunc(itemPriceNum * 0.1);
  const profitNum = itemPriceNum - addTaxPriceNum;

  profit.innerHTML = profitNum;
  addTaxPrice.innerHTML = addTaxPriceNum;
});
};

window.addEventListener("load",culc);