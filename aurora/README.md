# Apache Aurora dockerfiles

**[Aurora]**(http://aurora.apache.org/) - the framework for the mesos clusters that supports running long-running services, cron jobs, and ad-hoc jobs.

- **Aurora scheduler** - The scheduler is your primary interface to the work you run in your cluster. You will instruct it to run jobs, and it will manage them in Mesos for you. You will also frequently use the scheduler’s read-only web interface as a heads-up display for what’s running in your cluster.
- **Aurora executor** - The executor (a.k.a. Thermos executor) is responsible for carrying out the workloads described in the Aurora DSL (.aurora files). The executor is what actually executes user processes. It will also perform health checking of tasks and register tasks in ZooKeeper for the purposes of dynamic service discovery.
