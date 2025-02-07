import React, { useState, useEffect } from 'react';

const Payment = () => {
    const [payments, setPayments] = useState([]);

    useEffect(() => {
        // Fetch payment data from the blockchain
        async function fetchPayments() {
            // Your logic to fetch payments from the blockchain
        }

        fetchPayments();
    }, []);

    return (
        <div className="p-4">
            <h1 className="text-2xl font-bold mb-4">Payments</h1>
            <ul className="list-disc pl-5">
                {payments.map(payment => (
                    <li key={payment.order_id} className="mb-2">
                        <span className="font-semibold">Order ID:</span> {payment.order_id}, 
                        <span className="font-semibold"> Amount:</span> {payment.amount}, 
                        <span className="font-semibold"> Status:</span> {payment.status}
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default Payment;
