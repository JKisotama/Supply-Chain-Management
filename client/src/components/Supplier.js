import React, { useState, useEffect } from 'react';

const Supplier = () => {
    const [suppliers, setSuppliers] = useState([]);

    useEffect(() => {
        // Fetch supplier data from the blockchain
        async function fetchSuppliers() {
            // Your logic to fetch suppliers from the blockchain
        }

        fetchSuppliers();
    }, []);

    return (
        <div className="p-4">
            <h1 className="text-2xl font-bold mb-4">Suppliers</h1>
            <ul className="list-disc pl-5">
                {suppliers.map(supplier => (
                    <li key={supplier.id} className="mb-2">
                        <span className="font-semibold">{supplier.name}</span>: {supplier.address}
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default Supplier;
