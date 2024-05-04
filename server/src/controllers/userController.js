const userService = require("../services/userService");
const multer = require("multer");

// Controller function to handle creating a new user
const createUser = async (req, res) => {
  try {
    const newUser = await userService.createUser(req.body);
    res.status(201).send({
      status: "success",
      newUser,
      message: "User registered successfully!",
    });
  } catch (error) {
    res
      .status(400)
      .send({ status: "failed", message: "Email id already exist!" });
  }
};

const loginUser = async (req, res) => {
  try {
    const { email, password } = req.body;
    const { user, token } = await userService.authenticateUser(email, password);
    res.send({
      status: "success",
      user,
      token,
      message: "User logged in successfully!",
    });
  } catch (error) {
    res.status(400).send({ status: "failed", message: "Login failed!" });
  }
};

const logoutUser = async (req, res) => {
  try {
    const success = await userService.logoutUser(req.user, req.token);
    if (success) {
      res.send({ status: "success", message: "Logout successfully!" });
    } else {
      throw new Error("Logout failed");
    }
  } catch (error) {
    res.status(500).send({ status: "failed", message: "Logout failed!" });
  }
};

const fetchUser = async (req, res) => {
  try {
    res.send({
      status: "success",
      user: req.user,
      message: "User fetched successfully!",
    });
  } catch (error) {
    res.status(500).send({
      status: "failed",
      user: req.user,
      message: "Failed to fetch user!",
    });
  }
};

const updateUserProfile = async (req, res) => {
  const updates = Object.keys(req.body);
  const allowedUpdates = ["name", "age", "email", "password"];
  const validUpdates = updates.every((e) => allowedUpdates.includes(e));

  if (!validUpdates) {
    return res
      .status(400)
      .send({ status: "failed", message: "Invalid updates!" });
  }

  try {
    const updatedUser = await userService.updateUserProfile(
      req,
      updates
    );
    res.send({
      status: "success",
      user: updatedUser,
      message: "User profile updated successfully!",
    });
  } catch (error) {
    res
      .status(500)
      .send({ status: "failed", message: "Failed to update user profile!" });
  }
};

const deleteUser = async (req, res) => {
  try {
    const deletedUser = await userService.deleteUser(req.user._id);
    res.status(200).send({
      status: "success",
      user: deletedUser,
      message: "Account deleted successfully!",
    });
  } catch (error) {
    res
      .status(500)
      .send({ status: "failed", message: "Failed to delete account!" });
  }
};

const uploadAvatar = async (req, res, next) => {
  try {
    await userService.processAndSaveAvatar(req.user, req.file.buffer);
    res.send({
      status: "success",
      message: "Image uploaded successfully!",
    });
  } catch (error) {
    next(error);
  }
};

const upload = multer({
  limits: {
    fileSize: 2000000,
  },
  fileFilter(req, file, cb) {
    if (!file.originalname.match(/\.(jpg|jpeg|png)$/)) {
      return cb(new Error("Please upload an image!"));
    }
    cb(undefined, true);
  },
});

const handleImageUploadError = (error, req, res, next) => {
  res.status(400).send({
    status: "failed",
    message: "Failed to upload image!",
  });
};

const getUserAvatar = async (req, res) => {
  try {
    const avatar = await userService.getUserAvatar(req.params.id);
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.set("content-type", "image/png");
    res.send(avatar);
  } catch (error) {
    res.status(404).send();
  }
};

const deleteAvatar = async (req, res) => {
  try {
    req.user.avatar = undefined;
    await req.user.save();
    res.send("Avatar deleted successfully!");
  } catch (error) {
    res.status(500).send("Failed to delete avatar!");
  }
};

module.exports = {
  createUser,
  loginUser,
  logoutUser,
  fetchUser,
  updateUserProfile,
  deleteUser,
  uploadAvatar,
  handleImageUploadError,
  getUserAvatar,
  deleteAvatar,
  upload,
};
