const express = require("express");
const auth = require("../middleware/auth");
const {
  createTask,
  getTasks,
  getTaskById,
  updateTask,
  deleteTask,
} = require("../controllers/taskController");

const router = new express.Router();

router.post("/tasks", auth, createTask);
router.get("/tasks", auth, getTasks);
router.get("/tasks/:id", auth, getTaskById);
router.patch("/tasks/:id", auth, updateTask);
router.delete("/tasks/:id", auth, deleteTask);

module.exports = router;
