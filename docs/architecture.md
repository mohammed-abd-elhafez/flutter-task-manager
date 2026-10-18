# Task Manager Architecture

The app is organized by feature. The task feature owns its data source, domain models, controller, and widgets. The page observes a controller and does not know whether tasks came from mock data, an API, or a database.

The controller is intentionally small for this first iteration. It owns loading state, filtering, progress calculation, and the workflow transition rule. This keeps user intent out of the widgets and makes the important behavior testable without rendering a screen.

## Business rules

A task moves from `To do` to `In progress`, then to `Done`, and tapping a completed task starts the cycle again. Completion rate is completed tasks divided by all tasks; an empty collection returns zero rather than dividing by zero.
