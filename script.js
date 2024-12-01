document.addEventListener("DOMContentLoaded", function () {
    // Termékek adatainak definiálása
    const products = [
        { id: 1, name: "Fehér Póló", price: 4990, image: "shirt1.jpg", sizes: ["S", "M", "L"], category: "női" },
        { id: 2, name: "Fekete Póló", price: 4990, image: "shirt2.jpg", sizes: ["S", "M", "L"], category: "férfi" },
        { id: 3, name: "Piros Póló", price: 4990, image: "shirt3.jpg", sizes: ["S", "M", "L"], category: "unisex" },
        { id: 4, name: "Kék Póló", price: 4990, image: "shirt4.jpg", sizes: ["S", "M", "L"], category: "női" },
        { id: 5, name: "Zöld Póló", price: 4990, image: "shirt5.jpg", sizes: ["S", "M", "L"], category: "férfi" },
    ];

    const cart = [];
    const cartModal = document.getElementById("cartModal");
    const cartItemsContainer = document.getElementById("cart-items");
    const cartTotalPrice = document.getElementById("cart-total-price");
    const cartLink = document.getElementById("cart-link");
    const productGrid = document.getElementById("product-grid");

    // Formázás pénzhez
    function formatPrice(price) {
        return price.toLocaleString() + " Ft";
    }

    // Termékek megjelenítése
    function displayProducts(filteredProducts) {
        productGrid.innerHTML = "";
        filteredProducts.forEach(product => {
            const productHTML = `
                <div class="product-item">
                    <img src="${product.image}" alt="${product.name}">
                    <h3>${product.name}</h3>
                    <p>${formatPrice(product.price)}</p>
                    <div class="product-options">
                        <select id="size-${product.id}">
                            ${product.sizes.map(size => `<option value="${size}">${size}</option>`).join('')}
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
    function filterProducts(category) {
        let filteredProducts = [];

        if (category === 'none') {
            filteredProducts = products;  // Ha nincs kategória szűrés, mutassa az összes terméket
        } else {
            filteredProducts = products.filter(product => product.category === category);
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
        let totalPrice = 0;

        cart.forEach(item => {
            const { product, size, quantity } = item;
            totalPrice += product.price * quantity;

            const cartItemHTML = `
                <div class="cart-item">
                    <img src="${product.image}" alt="${product.name}">
                    <div class="cart-item-details">
                        <p>${product.name}</p>
                        <p>Ár: ${formatPrice(product.price)}</p>
                        <label for="size-${product.id}">Méret:</label>
                        <select id="size-${product.id}" class="cart-item-size">
                            ${product.sizes.map(sizeOption => `<option value="${sizeOption}" ${sizeOption === size ? 'selected' : ''}>${sizeOption}</option>`).join('')}
                        </select>
                        <label for="quantity-${product.id}">Mennyiség:</label>
                        <input type="number" id="quantity-${product.id}" value="${quantity}" min="1" class="cart-item-quantity">
                    </div>
                    <div class="cart-item-price">${formatPrice(product.price * quantity)}</div>
                </div>
            `;
            cartItemsContainer.innerHTML += cartItemHTML;
        });

        cartTotalPrice.innerText = formatPrice(totalPrice);
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
});
