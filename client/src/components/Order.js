import React, { useState, useEffect } from 'react';

const Order = () => {
    const [orders, setOrders] = useState([]);

    useEffect(() => {
        // Fetch order data from the blockchain
        async function fetchOrders() {
            // Your logic to fetch orders from the blockchain
        }

        fetchOrders();
    }, []);

    return (
        <div className="p-4">
            <h1 className="text-2xl font-bold mb-4">Orders</h1>
            <ul className="list-disc pl-5">
                {orders.map(order => (
                    <li key={order.id} className="mb-2">
                        <span className="font-semibold">Order ID:</span> {order.id}, 
                        <span className="font-semibold"> Item ID:</span> {order.item_id}, 
                        <span className="font-semibold"> Quantity:</span> {order.quantity}, 
                        <span className="font-semibold"> Status:</span> {order.status}
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default Order;
