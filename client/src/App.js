import React from 'react';
import Inventory from './components/Inventory';
import Supplier from './components/Supplier';
import Order from './components/Order';
import Payment from './components/Payment';

const App = () => {
    return (
        <div className="container mx-auto p-4">
            <h1 className="text-3xl font-bold mb-6">Supply Chain Management App</h1>
            <div className="grid grid-cols-1 gap-6">
                <Inventory />
                <Supplier />
                <Order />
                <Payment />
            </div>
        </div>
    );
};

export default App;
