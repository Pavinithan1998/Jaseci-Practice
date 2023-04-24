// node main_root; 

node state{
    has title;
    has message;
    has prompts;
}

edge transition{
    has selected;
}

graph chatbot{
    has anchor main_root;

    spawn {
        //level 0
        main_root = spawn node::state(
            title = "Welcome",
            message = "Welcome to Facebook People's bank portal, How can I help you?",
            prompts = ["Check Balance", "Transaction", "Message Service", "Pawning"]
        );
        //level 1
        balance = spawn main_root +[transition(selected="Check Balance")]+> node::state(
            title = "Balance",
            message = "Account type? ",
            prompts = ["Saving", "Current", "Fixed", "Joint","Back"]
        );
        transaction = spawn main_root +[transition(selected="Transaction")]+> node::state(
            title = "Transaction",
            message = "Transaction type? ",
            prompts = ["Peoples bank", "Interbank", "Branch to branch"]
        );
        message = spawn main_root +[transition(selected="Message Service")]+> node::state(
            title = "message",
            message = "Actions... ",
            prompts = ["Add new", "Stop current"]
        );
        pawning = spawn main_root +[transition(selected="Pawning")]+> node::state(
            title = "Pawning",
            message = "Select the service...",
            prompts = ["Check my status", "Current rates", "Auctions"]
        );
        main_root +[transition(selected="Check Balance")]+> balance;
        main_root +[transition(selected="Transaction")]+> transaction;
        main_root +[transition(selected="Message Service")]+> message;
        main_root +[transition(selected="Pawning")]+> pawning;

        //level2
        saving_balance = spawn balance +[transition(selected="Saving")]+> node::state(
            title="savingbalance",
            message="Your saving acoount balance is 10,485.00 ",
            prompts=["Main menu", "Make transaction", "Quit"]
        );

        current_balance = spawn balance +[transition(selected="Current")]+> node::state(
            title="currentbalance",
            message="Your current acoount balance is 25,545.00 ",
            prompts=["Main menu", "Make transaction", "Quit"]
        );

        fixed_balance = spawn balance +[transition(selected="Fixed")]+> node::state(
            title="fixedbalance",
            message="Your fixed acoount balance is 2,550,896.00 ",
            prompts=["Main menu", "Quit"]
        );

        joint_balance = spawn balance +[transition(selected="Joint")]+> node::state(
            title="jointbalance",
            message="Your joint acoount balance is 10,485.00 ",
            prompts=["Main menu", "Make transaction", "Quit"]
        );

        balance +[transition(selected="Saving")]+> saving_balance;
        balance +[transition(selected="Current")]+> current_balance;
        balance +[transition(selected="Fixed")]+> fixed_balance;
        balance +[transition(selected="Joint")]+> joint_balance;

        balance +[transition(selected="Back")]+> main_root;

        saving_balance +[transition(selected="Main menu")]+> main_root;
        current_balance +[transition(selected="Main menu")]+> main_root;
        fixed_balance +[transition(selected="Main menu")]+> main_root;
        joint_balance +[transition(selected="Main menu")]+> main_root;
        saving_balance +[transition(selected="Make transaction")]+> transaction;
        saving_balance +[transition(selected="Make transaction")]+> transaction;
        current_balance +[transition(selected="Make transaction")]+> transaction;
        joint_balance +[transition(selected="Make transaction")]+> transaction;
        


        //level 2 
        peoples_transfer = spawn transaction +[transition(selected="Peoples bank")]+> node::state(
            title="Peoplesbank",
            message="Your Transaction with People's bank account is done! Anything else?",
            prompts=["Make another transaction", "Check Balance", "Main menu", "Quit"]
        );

        interbank_transfer = spawn transaction +[transition(selected="Interbank")]+> node::state(
            title="Interbank",
            message="Your Transaction with other bank account is done! Anything else?",
            prompts=["Make another transaction", "Check Balance", "Main menu", "Quit"]
        );

        branch_transfer = spawn transaction +[transition(selected="Branch to branch")]+> node::state(
            title="Branchtobranch",
            message="Your Transaction of Branch to Branch is done! Anything else?",
            prompts=["Make another transaction", "Check Balance", "Main menu", "Quit"]
        );

        transaction +[transition(selected="Peoples bank")]+> peoples_transfer;
        transaction +[transition(selected="Interbank")]+> interbank_transfer;
        transaction +[transition(selected="Branch to branch")]+> branch_transfer;

        peoples_transfer +[transition(selected="Make another transaction")]+> transaction;
        interbank_transfer +[transition(selected="Make another transaction")]+> transaction;
        branch_transfer +[transition(selected="Make another transaction")]+> transaction;

        peoples_transfer +[transition(selected="Check Balance")]+> balance;
        interbank_transfer +[transition(selected="Check Balance")]+> balance;
        branch_transfer +[transition(selected="Check Balance")]+> balance;

        peoples_transfer +[transition(selected="Main menu")]+> main_root;
        interbank_transfer +[transition(selected="Main menu")]+> main_root;
        branch_transfer +[transition(selected="Main menu")]+> main_root;
    }
}
walker talker {
    has choice;

    state{
        std.out(here.message, here.prompts);
        choice = std.input(">>> ");

        if(choice=="Quit"): disengage;

        take -[transition(selected==choice)]->node::state else{
            take here;
        }
    }
}

walker init {
    root {
        spawn here ++> graph::chatbot;
        spawn --> walker::talker;
    }
}
