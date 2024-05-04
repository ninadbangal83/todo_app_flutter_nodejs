const express = require("express");
const auth = require("../middleware/auth");
const {
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
} = require("../controllers/userController");

const router = new express.Router();

router.post("/user", createUser);
router.post("/user/login", loginUser);
router.post("/user/logout", auth, logoutUser);
router.get("/user/me", auth, fetchUser);
router.patch("/user/me", auth, updateUserProfile);
router.delete("/user/me", auth, deleteUser);
router.post(
  "/user/me/avatar",
  auth,
  upload.single("avatar"),
  uploadAvatar,
  handleImageUploadError
);
router.get("/user/:id/avatar", getUserAvatar);
router.delete("/user/me/avatar", deleteAvatar);

module.exports = router;
