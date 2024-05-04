// controllers/taskController.js

const taskService = require("../services/taskService");

const createTask = async (req, res) => {
    try {
        const task = await taskService.createTask(req.body, req.user._id);
        res.status(201).send({
            status: "success",
            task: task,
            message: "Task created successfully!",
          });
    } catch (error) {
        res.status(400).send({
            status: "failed",
            message: "Failed to create task!",
          });
    }
};

const getTasks = async (req, res) => {
    try {
        const tasks = await taskService.getTasks(req.user, req.query);
        res.send(tasks);
    } catch (error) {
        res.status(500).send({
            status: "failed",
            message: "Failed to get task!",
          });
    }
};

const getTaskById = async (req, res) => {
    try {
        const task = await taskService.getTaskById(req.params.id, req.user._id);
        res.send(task);
    } catch (error) {
        res.status(404).send(error.message);
    }
};

const updateTask = async (req, res) => {
    try {
        const task = await taskService.updateTask(req.params.id, req.body, req.user._id);
        res.send({
            status: "success",
            task: task,
            message: "Task updated successfully!",
          });
    } catch (error) {
        res.status(404).send({
            status: "failed",
            message: "Failed to update task!",
          });
    }
};

const deleteTask = async (req, res) => {
    try {
        const task = await taskService.deleteTask(req.params.id, req.user._id);
        res.send({
            status: "success",
            task: task,
            message: "Task deleted successfully!",
          });
    } catch (error) {
        res.status(404).send({
            status: "failed",
            message: "Failed to delete task!",
          });
    }
};

module.exports = {
    createTask,
    getTasks,
    getTaskById,
    updateTask,
    deleteTask,
};
