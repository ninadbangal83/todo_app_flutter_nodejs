const User = require("../models/userModel");
const sharp = require("sharp");

// Function to create a new user
const createUser = async (userData) => {
  try {
    const newUser = new User(userData);
    const savedUser = await newUser.save();
    return savedUser;
  } catch (error) {
    throw new Error("Could not create user");
  }
};

const authenticateUser = async (email, password) => {
  try {
    const user = await User.findCredentials(email, password);
    const token = await user.generateAuthToken();
    return { user, token };
  } catch (error) {
    throw new Error("Authentication failed");
  }
};

const logoutUser = async (user, token) => {
  try {
    user.tokens = user.tokens.filter((t) => t.token !== token);
    await user.save();
    return true;
  } catch (error) {
    throw new Error("Logout failed");
  }
};

const updateUserProfile = async (req, updates) => {
  try {
    const user = await User.findById(req.user._id);
    if (!user) {
      throw new Error("User not found");
    }
    updates.forEach((update) => (user[update] = req.body[update]));
    await user.save();
    return user;
  } catch (error) {
    throw new Error("Failed to update user profile");
  }
};

const deleteUser = async (userId) => {
  try {
    const user = await User.findByIdAndDelete(userId);
    if (!user) {
      throw new Error("User not found");
    }
    return user;
  } catch (error) {
    throw new Error("Failed to delete user");
  }
};

const processAndSaveAvatar = async (user, imageBuffer) => {
  try {
    const resizedImageBuffer = await sharp(imageBuffer)
      .resize({ width: 250, height: 250 })
      .png()
      .toBuffer();
    user.avatar = resizedImageBuffer;
    await user.save();
  } catch (error) {
    throw new Error("Failed to process and save avatar");
  }
};

const getUserAvatar = async (userId) => {
  try {
    const user = await User.findById(userId);
    if (!user || !user.avatar) {
      throw new Error("User or avatar not found");
    }
    return user.avatar;
  } catch (error) {
    throw new Error("Failed to get user avatar");
  }
};

module.exports = {
  createUser,
  authenticateUser,
  logoutUser,
  updateUserProfile,
  deleteUser,
  processAndSaveAvatar,
  getUserAvatar,
};
