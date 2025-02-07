# Supply Chain Management

A decentralized supply chain management system built using the Move language on the Sui blockchain.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Modules](#modules)


## Introduction

This project aims to provide a decentralized solution for managing supply chain operations, including inventory management, order processing, and payment handling.

## Features

- Initialize inventory
- Add inventory items
- Update item quantities
- Manage suppliers and orders
- Handle payments

## Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/yourusername/supplyChain.git
   cd supplyChain
2. **Install Rust:**
   ```sh
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
3. **Install Sui:**
   ```sh
   cargo install --locked --git https://github.com/MystenLabs/sui.git --branch main sui
## Usage
1. **Compile the Move modules:**
```sh
   sui move build
```
2. **Deploy the modules to the Sui blockchain:**
```sh
   git clone https://github.com/yourusername/supplyChain.git
   cd supplyChain
```
3. **Interact with the deployed modules:**
   - Initialize inventory:
```sh
   sui client call --function initialize_inventory --args <account_address>
```
   - Add item to inventory:
```sh
   sui client call --function add_item --args <account_address> <item_id> <item_name> <quantity> <supplier_address>
```
   - Update item quantity:
```sh
   sui client call --function update_quantity --args <account_address> <item_id> <new_quantity>
```
## Modules
[Inventory.move]
- Defines the Inventory and InventoryItem structures and provides functions to initialize inventory, add items, and update item quantities.
```
   module SupplyChain {
       struct InventoryItem {
           id: u64,
           name: vector<u8>,
           quantity: u64,
           supplier: address,
       }
   
       resource struct Inventory {
           items: vector<InventoryItem>,
       }
   
       public fun initialize_inventory(account: &signer) {
           let inventory = Inventory { items: vector[] };
           move_to(account, inventory);
       }
   
       public fun add_item(account: &signer, id: u64, name: vector<u8>, quantity: u64, supplier: address) {
           let inventory = borrow_global_mut<Inventory>(Signer::address_of(account));
           let new_item = InventoryItem { id, name, quantity, supplier };
           vector::push_back(&mut inventory.items, new_item);
       }
   
       public fun update_quantity(account: &signer, id: u64, new_quantity: u64) {
           let inventory = borrow_global_mut<Inventory>(Signer::address_of(account));
           let index = vector::index_where(&inventory.items, (item: &InventoryItem) => item.id == id);
           *&mut inventory.items[index].quantity = new_quantity;
       }
   
       public fun get_inventory(account: &signer): &Inventory {
           borrow_global<Inventory>(Signer::address_of(account))
       }
   }
```
