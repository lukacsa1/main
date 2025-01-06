document.addEventListener("DOMContentLoaded", function () {
    fetch('https://localhost:7117/termekek')
    .then(response => response.json())
    .then(data => {
        // Az új termékek hozzáadása a tömbhöz
        const allproducts = [...data]; // A fetch válaszban érkező adatok a 'data' változóban vannak
        console.log(allproducts); // Az új tömb kiírása

        // A termékek elérhetősége a 'products' tömbben
        const products = [...allproducts];

        // Termékek adatainak definiálása
        const cart = [];
        const cartModal = document.getElementById("cartModal");
        const cartItemsContainer = document.getElementById("cart-items");
        const cartTotalar = document.getElementById("cart-total-ar");
        const cartLink = document.getElementById("cart-link");
        const productGrid = document.getElementById("product-grid");

        // Formázás pénzhez
        function formatar(ar) {
            return ar.toLocaleString() + " Ft";
        }

        // Termékek megjelenítése
        function displayProducts(filteredProducts) {
            productGrid.innerHTML = "";
            filteredProducts.forEach(product => {
                const productHTML = `
                    <div class="product-item">
                        <img src="${product.kep}" alt="${product.termekNeve}">
                        <h3>${product.termekNeve}</h3>
                        <p>${formatar(product.ar)}</p>
                        <div class="product-options">
                            <select id="size-${product.id}">
                                ${JSON.parse(product.meret).map(size => `<option value="${size}">${size}</option>`).join('')}
                            </select>
                            <input type="number" id="quantity-${product.id}" value="1" min="1" max="10">
                        </div>
                        <button class="buy-now" data-id="${product.id}">Megvásárol</button>
                    </div>
                `;
                productGrid.innerHTML += productHTML;
            });
        }

        // Kategória szűrés
        function filterProducts(kategoria) {
            let filteredProducts = [];

            if (kategoria === 'none') {
                filteredProducts = products;  // Ha nincs kategória szűrés, mutassa az összes terméket
            } else {
                filteredProducts = products.filter(product => product.kategoria === kategoria);
            }

            displayProducts(filteredProducts);
        }

        // Kosárba helyezés logika
        document.addEventListener("click", function (event) {
            if (event.target.classList.contains("buy-now")) {
                const productId = event.target.getAttribute("data-id");
                const selectedSize = document.querySelector(`#size-${productId}`).value;
                const quantity = document.querySelector(`#quantity-${productId}`).value;

                // Kosárba rakás
                const product = products.find(p => p.id == productId);

                // Ellenőrzés, hogy a termék már benne van-e a kosárban
                const existingItemIndex = cart.findIndex(item => item.product.id === productId && item.size === selectedSize);
                if (existingItemIndex !== -1) {
                    // Ha már benne van, frissítjük a mennyiséget
                    cart[existingItemIndex].quantity += parseInt(quantity);
                } else {
                    // Ha nincs benne, hozzáadjuk
                    cart.push({ product, size: selectedSize, quantity: parseInt(quantity) });
                }

                updateCartModal();
            }
        });

        // Kosár felugró ablak frissítése
        function updateCartModal() {
            cartItemsContainer.innerHTML = "";
            let totalar = 0;

            cart.forEach(item => {
                const { product, size, quantity } = item;
                totalar += product.ar * quantity;

                const cartItemHTML = `
                    <div class="cart-item">
                        <img src="${product.kep}" alt="${product.termekNeve}">
                        <div class="cart-item-details">
                            <p>${product.termekNeve}</p>
                            <p>Ár: ${formatar(product.ar)}</p>
                            <p>Méret: ${JSON.parse(product.meret)}</p>
                            <label for="size-${product.id}">Méret:</label>
                            <select id="size-${product.id}" class="cart-item-size">
                                ${JSON.parse(product.meret).map(sizeOption => `<option value="${sizeOption}" ${sizeOption === size ? 'selected' : ''}>${sizeOption}</option>`).join('')}
                            </select>
                            <label for="quantity-${product.id}">Mennyiség:</label>
                            <input type="number" id="quantity-${product.id}" value="${quantity}" min="1" class="cart-item-quantity">
                        </div>
                        <div class="cart-item-ar">${formatar(product.ar * quantity)}</div>
                    </div>
                `;
                cartItemsContainer.innerHTML += cartItemHTML;
            });

            cartTotalar.innerText = formatar(totalar);
            cartLink.innerText = `Kosár (${cart.length})`;
        }

        // Kosár modal bezárása
        function closeCartModal() {
            cartModal.style.display = "none";
        }

        // Kosár megjelenítése
        function openCartModal() {
            cartModal.style.display = "block";
        }

        // Kosár tartalma elmentésése
        function checkout() {
            alert("Vásárlás!");
        }

        // Alapértelmezett termékek megjelenítése
        displayProducts(products);
    })
    .catch(error => console.error('Hiba a fetch kérés során:', error));
});
