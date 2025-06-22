const price = () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  if (!priceInput || !addTaxDom || !profitDom) return;

  priceInput.addEventListener("input", () => {
    const inputValue = parseInt(priceInput.value);

    if (isNaN(inputValue) || inputValue < 0) {
      addTaxDom.innerHTML = '0';
      profitDom.innerHTML = '0';
      return;
    }

    const tax = Math.floor(inputValue * 0.1);
    const profit = inputValue - tax;

    addTaxDom.innerHTML = tax.toLocaleString();
    profitDom.innerHTML = profit.toLocaleString();
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);