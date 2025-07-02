# KICK-OFF PLAN: {{plan_file_path}}

Hey Cascade, it's time to execute the plan located at `{{plan_file_path}}`.

Your mission is to follow this plan precisely from beginning to end. Stick to the script!

---

### **BEFORE YOU START: PREP CHECKLIST**

Before you take your first step in the plan, please run through this checklist. This is mandatory.

- [ ] **Get Your Bearings:** Quickly check your recent memories and the `TASKS.md` file. I need you to understand where we left off and how this task fits into the bigger picture.
- [ ] **Read the Plan:** Open up `{{plan_file_path}}` and read the whole thing, including the YAML section at the top.
- [ ] **Confirm Dependencies:** Look at the `task_id` in the plan's YAML. Go to `TASKS.md` and make sure all tasks listed in its `depends_on` section are marked as `done`. If not, STOP and tell me what's blocking us.
- [ ] **Check Your Tools & Docs:** Look at the `context_files` in the plan's YAML. Make sure every single one of those files actually exists. If anything is missing, STOP and let me know.
- [ ] **Load Your Instructions:** Load the `rule_mode` file and all the other `context_files` (especially the `guide-*.md` files) into your working context. You need to follow these rules for the entire task.
- [ ] **Ready to Go:** Give me a quick confirmation that you've completed this prep list and are ready to start.

---

### **LET'S GO: EXECUTING THE PLAN**

Once you've done your prep, start working through the plan's main checklist.

*   **One Step at a Time:** Go in order. Don't skip ahead.
*   **Think Aloud:** Before you do something, tell me which checklist item you're working on.
*   **Show Your Work:** After you finish a step, show me the updated checklist with the box ticked off (`- [x]`).
*   **Stay on Track:** Use the rules and guides you loaded from the `context_files` to make your decisions.

---

### **IF SOMETHING GOES WRONG**

If you hit an error, a test fails, or anything unexpected happens:
1.  **STOP** immediately.
2.  Tell me what went wrong.
3.  Explain what you expected to happen vs. what actually happened.
4.  Wait for my instructions.

---

### **WHEN YOU'RE DONE**

After you've checked off the very last item in the plan's `Final Stage`:
1.  Update the `status` in the plan file's YAML header to `done`.
2.  Go to `TASKS.md` and update the status for this task to `done`.
3.  Let me know it's all wrapped up!
