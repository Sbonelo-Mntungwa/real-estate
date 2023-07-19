"use client";
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
import { useStateContext } from "../context";
import { checkIfImage } from "../utils";

const page = () => {
  const { address, connect, contract, realEstate, createPropertyFunction } =
    useStateContext();

  const [isLoading, setIsLoading] = useState(false);

  const [form, setForm] = useState({
    propertyTitle: "",
    description: "",
    category: "",
    price: "",
    images: "",
    propertyAddress: "",
  });

  const handleFormFieldChange = (fieldName, e) => {
    setForm({ ...form, [fieldName]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    checkIfImage(form.images, async (exists) => {
      if (exists) {
        setIsLoading(true);
        await createPropertyFunction({
          ...form,
          price: ethers.utils.parseUnits(form.price, 18),
        });
        setIsLoading(false);
      } else {
        alert("Please provide valid image URL");
        setForm({ ...form, images: "" });
      }
    });
  };

  return (
    <div>
      <h1>{realEstate}</h1>
      <button onClick={() => connect()}>Connect</button>
      <h1>Create</h1>
      <form onSubmit={handleSubmit}>
        <div>
          <input
            type="text"
            placeholder="propertyTitle"
            onChange={(e) => handleFormFieldChange("propertyTitle", e)}
          />
        </div>
        <div>
          <input
            type="text"
            placeholder="description"
            onChange={(e) => handleFormFieldChange("description", e)}
          />
        </div>
        <div>
          <input
            type="text"
            placeholder="category"
            onChange={(e) => handleFormFieldChange("category", e)}
          />
        </div>
        <div>
          <input
            type="number"
            placeholder="price"
            onChange={(e) => handleFormFieldChange("price", e)}
          />
        </div>
        <div>
          <input
            type="url"
            placeholder="images"
            onChange={(e) => handleFormFieldChange("images", e)}
          />
        </div>
        <div>
          <input
            type="text"
            placeholder="propertyAddress"
            onChange={(e) => handleFormFieldChange("propertyAddress", e)}
          />
        </div>
        <button type="submit">Submit</button>
      </form>
    </div>
  );
};

export default page;
