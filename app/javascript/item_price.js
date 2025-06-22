const priceInput = document.getElementById("item-price");
priceInput.addEventListener("input", () => {
   const inputValue = priceInput.value;
   const addTaxDom = document.getElementById('add-tax-price');
    addTaxDom.innerHTML = Math.round(priceInput.value * 0.1 );
   const profitDom = document.getElementById('profit');
    profitDom.innerHTML = Math.round(priceInput.value - Math.round(priceInput.value * 0.1 ))
})