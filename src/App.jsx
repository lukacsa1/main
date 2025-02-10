import React, { useState, useEffect } from "react";
import "./App.css";

const App = () => {
  const [products, setProducts] = useState([]);
  const [cart, setCart] = useState([]);
  const [category, setCategory] = useState("none");
  const [selectedCategory, setSelectedCategory] = useState("Ajánlott termékek");
  const [searchQuery, setSearchQuery] = useState("");
  const [showCart, setShowCart] = useState(false); // Kosár megjelenítése
  const [showLogin, setShowLogin] = useState(false); // Bejelentkezési modal megjelenítése
  const [showRegistration, setShowRegistration] = useState(false); // Bejelentkezési modal megjelenítése

  useEffect(() => {
    fetch("https://localhost:7117/Termekek/GetProducts")
      .then((response) => response.json())
      .then((data) => setProducts(data))
      .catch((error) => console.error("Hiba a fetch kérés során:", error));
  }, []);

  const addToCart = (product, size, quantity) => {
    setCart((prevCart) => {
      const existingItem = prevCart.find(
        (item) => item.product.id === product.id && item.size === size
      );
      if (existingItem) {
        return prevCart.map((item) =>
          item.product.id === product.id && item.size === size
            ? { ...item, quantity: item.quantity + quantity }
            : item
        );
      }
      return [...prevCart, { product, size, quantity }];
    });
  };

  const removeFromCart = (productId, size) => {
    setCart((prevCart) => prevCart.filter((item) => !(item.product.id === productId && item.size === size)));
  };

  const handleCategoryChange = (e, categoryName, categoryTitle) => {
    e.preventDefault();
    setCategory(categoryName);
    setSelectedCategory(categoryTitle); // 🔹 Kategória címének frissítése
  };

  const handleSearchChange = (e) => {
    setSearchQuery(e.target.value);
  };


  return (
    <div>
      <Navbar cartSize={cart.length} setCategory={setCategory} setSearchQuery={setSearchQuery} handleCategoryChange={handleCategoryChange} setShowCart={setShowCart} setShowLogin={setShowLogin} />
      <Banner />
      <ProductGrid products={products} category={category}  selectedCategory={selectedCategory} searchQuery={searchQuery} addToCart={addToCart} />
      {showCart && <Cart cart={cart} removeFromCart={removeFromCart} setShowCart={setShowCart} />}
      {showLogin && <LoginModal setShowLogin={setShowLogin} setShowRegistration={setShowRegistration}/>} {/* 🔹 Bejelentkezési modal */}
      {showRegistration && <RegistrationModal setShowRegistration={setShowRegistration} />} {/* 🔹 Bejelentkezési modal */}
    </div>
  );
};

//Navigációs sáv
const Navbar = ({ cartSize, setCategory, setSearchQuery, handleCategoryChange, setShowCart, setShowLogin }) => {
  const handleSearchChange = (e) => {
    setSearchQuery(e.target.value);
  };

  return (
    <nav className="navbar-right">
      <div className="logo">Pólók</div>
      <ul className="nav-links">
        <li>
          <a href="#" onClick={(e) => handleCategoryChange(e, "none",  "Összes póló") }>Összes</a>
        </li>
        <li>
          <a href="#" onClick={(e) => handleCategoryChange(e, "Női",  "Női pólók")}>Női</a>
        </li>
        <li>
          <a href="#" onClick={(e) => handleCategoryChange(e, "Férfi", "Férfi pólók")}>Férfi</a>
        </li>
        <li>
          <a href="#" onClick={(e) => handleCategoryChange(e, "Unisex",  "Unisex pólók")}>Unisex</a>
        </li>
      </ul>
      <div className="search-bar">
        <input className="search-input" type="text" placeholder="Keresés..." onChange={handleSearchChange} />
      </div>
      <div className="cart-link" onClick={() => setShowCart(true)} style={{ cursor: "pointer" }}>
        Kosár: {cartSize}
      </div>
      <div className="login-link" onClick={() => setShowLogin(true)} style={{ cursor: "pointer" }}>
        Bejelentkezés
      </div>
    </nav>
  );
};

//Felirat
const Banner = () => {
  return (
    <section className="banner">
      <h2>Fedezd fel a legújabb pólóinkat!</h2>
      <p>Válassz a legfrissebb trendek közül és vásárolj online.</p>
    </section>
  );
};

//Termékek
const ProductGrid = ({ products, category, selectedCategory, searchQuery, addToCart }) => {
  const filteredProducts = products.filter(
    (product) =>
      (category === "none" || product.kategoria === category) &&
      product.termekNeve.toLowerCase().includes(searchQuery.toLowerCase())
  );

  return (
    <section className="featured-products">
      <h2>{selectedCategory}</h2>
      <div className="product-grid">
        {filteredProducts.map((product) => (
          <div key={product.id} className="product-item">
            <img src={product.kep} alt={product.termekNeve} />
            <h3>{product.termekNeve}</h3>
            <p>{product.ar.toLocaleString()} Ft</p>
            <div className="product-options">
              <select id={`size-${product.id}`}>
                {JSON.parse(product.meret).map((size) => (
                  <option key={size} value={size}>
                    {size}
                  </option>
                ))}
              </select>
              <input type="number" id={`quantity-${product.id}`} defaultValue="1" min="1" max="10" />
            </div>
            <button
              className="buy-now"
              onClick={() =>
                addToCart(
                  product,
                  document.getElementById(`size-${product.id}`).value,
                  parseInt(document.getElementById(`quantity-${product.id}`).value)
                )
              }
            >
              Kosárba
            </button>
          </div>
        ))}
      </div>
    </section>
  );
};

//Kosár
const Cart = ({ cart, removeFromCart, setShowCart }) => {
  const formatPrice = (price) => `${price.toLocaleString()} Ft`;
  const totalAmount = cart.reduce((sum, item) => sum + item.product.ar * item.quantity, 0);

  return (
    <div className="cart-modal">
      <div className="cart-modal-content">
        <span className="close-cart" onClick={() => setShowCart(false)}>×</span>
        <h2>Kosár</h2>
        {cart.length === 0 ? (
          <p>A kosár üres.</p>
        ) : (
          <>
            <div className="cart-items">
              {cart.map((item, index) => (
                <div key={index} className="cart-item">
                  <img src={item.product.kep} alt={item.product.termekNeve} />
                  <div className="cart-item-details">
                    <p>{item.product.termekNeve}</p>
                    <p>Ár: {formatPrice(item.product.ar)}</p>
                    <p>Méret: {item.size}</p>
                    <p>Mennyiség: {item.quantity}</p>
                  </div>
                  <button className="remove-btn" onClick={() => removeFromCart(item.product.id, item.size)}>
                    ❌
                  </button>
                </div>
              ))}
            </div>
            <div className="cart-total">
              <p>Összesen: {formatPrice(totalAmount)}</p>
              <button className="checkout-btn" onClick={() => alert("Vásárlás!")}>
                Pénztárhoz
              </button>
            </div>
          </>
        )}
      </div>
    </div>
  );
};

const LoginModal = ({ setShowLogin }) => {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError(""); // Reseteljük az esetleges előző hibát

    if (!username || !password) {
      setError("Felhasználónév és jelszó megadása kötelező!");
      return;
    }

    try {
      // Először lekérjük a sót a `GetSalt` végpontról
      const saltResponse = await fetch(`https://localhost:7117/api/Login/GetSalt/${username}`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
      });

      if (!saltResponse.ok) {
        throw new Error("Nem sikerült lekérni a sót!");
      }

      const salt = await saltResponse.text(); // A válasz szöveges formában
      console.log("Salt:", salt); // Kinyomtatjuk a sót, hogy lássuk

      // Ha a só üres, hibát dobunk
      if (!salt || salt === 'null') {
        throw new Error("A só nem érvényes vagy üres.");
      }

      // A jelszó és a só hashelése
      const tmpHash = await hashPassword(password, salt); // `hashPassword` egy hashelő függvény (pl. SHA256 vagy egyéb)

      // Most küldjük el a helyes formátumban
      const loginResponse = await fetch("https://localhost:7117/api/Login", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ loginName: username, tmpHash }), // A hashelt jelszó és a felhasználónév
      });

      const loginTextData = await loginResponse.text(); // A válasz szöveges formában

      // Ellenőrizzük, hogy a válasz JSON-e
      let data = {};
      try {
        data = JSON.parse(loginTextData); // Próbáljuk JSON-ként értelmezni
      } catch (err) {
        // Ha nem JSON, akkor nem próbáljuk értelmezni JSON-ként
        throw new Error("A válasz nem JSON formátumban érkezett!" + loginResponse.status + " " + loginTextData);
      }

      if (!loginResponse.ok) {
        throw new Error(data.message || "Hibás bejelentkezési adatok!");
      }

      // Sikeres bejelentkezés esetén elmentjük az adatokat
      localStorage.setItem("user", JSON.stringify(data.user));
      alert("Sikeres bejelentkezés!");
      setShowLogin(false);
      window.location.reload(); // Frissítjük az oldalt a változások megjelenítéséhez
    } catch (err) {
      setError(err.message); // A hibát jelenítjük meg
    }
  };

  return (
    <div className="login-modal">
      <div className="login-modal-content">
        <span className="close-login" onClick={() => setShowLogin(false)}>×</span>
        <h2>Bejelentkezés</h2>
        {error && <p style={{ color: "red" }}>{error}</p>}
        <form onSubmit={handleSubmit}>
          <label>Felhasználónév:</label>
          <input
            type="text"
            placeholder="Felhasználónév"
            required
            value={username}
            onChange={(e) => setUsername(e.target.value)}
          />

          <label>Jelszó:</label>
          <input
            type="password"
            placeholder="Jelszó"
            required
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />

          <button type="submit">Belépés</button>
        </form>
      </div>
    </div>
  );
};

// Hashelési funkció például SHA256
const hashPassword = async (password, salt) => {
  const encoder = new TextEncoder();
  const data = encoder.encode(password + salt);
  const hashBuffer = await crypto.subtle.digest("SHA-256", data); // Hashing
  const hashArray = Array.from(new Uint8Array(hashBuffer)); // Array from buffer
  return hashArray.map(byte => byte.toString(16).padStart(2, '0')).join(''); // Hex formátum
};





//Regisztráció
const RegistrationModal = ({ setShowRegistration }) => {
  const [username, setUsername] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [error, setError] = useState(""); // Hibaüzenet állapota

  const handleSubmit = (e) => {
    e.preventDefault(); // Megakadályozza az oldal újratöltését

    if (password !== confirmPassword) {
      setError("A két jelszó nem egyezik! ❌"); // Hibaüzenet beállítása
      return;
    }

    setError(""); // Ha nincs hiba, töröljük a hibaüzenetet
    alert("Sikeres regisztráció! ✅"); // Ide jöhetne egy API hívás is
    setShowRegistration(false);
  };

  return (
    <div className="registration-modal">
      <div className="registration-modal-content">
        <span className="close-registration" onClick={() => setShowRegistration(false)}>×</span>
        <h2>Regisztráció</h2>
        <form onSubmit={handleSubmit}> {/* Megfelelő függvény */}
          <label>Felhasználónév:</label>
          <input type="text" placeholder="Felhasználónév" required value={username} onChange={(e) => setUsername(e.target.value)} />

          <label>E-mail:</label>
          <input type="email" placeholder="E-mail" required value={email} onChange={(e) => setEmail(e.target.value)} />

          <label>Jelszó:</label>
          <input type="password" placeholder="Jelszó" required value={password} onChange={(e) => setPassword(e.target.value)} />

          <label>Jelszó megerősítés:</label>
          <input type="password" placeholder="Jelszó újra" required value={confirmPassword} onChange={(e) => setConfirmPassword(e.target.value)} />

          {error && <p style={{ color: "red", fontSize: "14px", marginTop: "5px" }}>{error}</p>} {/* Hibaüzenet */}

          <button type="submit">Regisztráció</button>
        </form>
      </div>
    </div>
  );
};

export default App;
