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

        //level 2
        add_new = spawn message +[transition(selected="Peoples bank")]+> node::state(
            title="addnew",
            message="Your new number is added",
            prompts=["Main menu", "Quit"]
        );

        stop_current = spawn message +[transition(selected="Peoples bank")]+> node::state(
            title="stopcurrent",
            message="Your new number is added",
            prompts=["Main menu", "Quit"]
        );

        message +[transition(selected="Add new")]+> add_new;
        message +[transition(selected="Stop current")]+> stop_current;

        add_new +[transition(selected="Main menu")]+> main_root;
        stop_current +[transition(selected="Main menu")]+> main_root;

        //level 2 
        check_pawn_status = spawn pawning +[transition(selected="Check my status")]+> node::state(
            title="checkpawnstatus",
            message="You currently have 100,100.00 woth of pawning",
            prompts=["Main menu", "Quit"]
        );

        current_pawn_rates = spawn pawning +[transition(selected="Current rates")]+> node::state(
            title="currentpawnrates",
            message="Select category: ",
            prompts=["Gold", "Silver", "Diamond"]
        );

        pawn_auctions = spawn pawning +[transition(selected="Auctions")]+> node::state(
            title="pawnauctions",
            message="Select category: ",
            prompts=["Gold", "Silver", "Diamond"]
        );

        pawning +[transition(selected="Check my status")]+> check_pawn_status;
        pawning +[transition(selected="Current rates")]+> current_pawn_rates;
        pawning +[transition(selected="Auctions")]+> pawn_auctions;
    
        check_pawn_status +[transition(selected="Main menu")]+> main_root;

        //level 3
        gold_rate = spawn current_pawn_rates +[transition(selected="Gold")]+> node::state(
            title="goldrate",
            message="Gold current pawning rate is 100,000.00 per gram",
            prompts=["Main menu", "Quit"]
        );

        silver_rate = spawn current_pawn_rates +[transition(selected="Silver")]+> node::state(
            title="silverrate",
            message="silver current pawning rate is 50,000.00 per gram",
            prompts=["Main menu", "Quit"]
        );

        diamond_rate = spawn current_pawn_rates +[transition(selected="Diamond")]+> node::state(
            title="diamondrate",
            message="diamond current pawning rate is 250,000.00 per gram",
            prompts=["Main menu", "Quit"]
        );

        current_pawn_rates +[transition(selected="Gold")]+> gold_rate;
        current_pawn_rates +[transition(selected="Silver")]+> silver_rate;
        current_pawn_rates +[transition(selected="Diamond")]+> diamond_rate;

        gold_rate +[transition(selected="Main menu")]+> main_root;
        silver_rate +[transition(selected="Main menu")]+> main_root;
        diamond_rate +[transition(selected="Main menu")]+> main_root;

        //level 3
        gold_auction = spawn pawn_auctions +[transition(selected="Gold")]+> node::state(
            title="goldauction",
            message="Gold current auctions displayed here",
            prompts=["Main menu", "Quit"]
        );

        silver_auction = spawn pawn_auctions +[transition(selected="Silver")]+> node::state(
            title="silverauction",
            message="silver current auctions displayed here",
            prompts=["Main menu", "Quit"]
        );

        diamond_auction = spawn pawn_auctions +[transition(selected="Diamond")]+> node::state(
            title="diamondauction",
            message="diamond current auctions displayed here",
            prompts=["Main menu", "Quit"]
        );

        pawn_auctions +[transition(selected="Gold")]+> gold_auction;
        pawn_auctions +[transition(selected="Silver")]+> silver_auction;
        pawn_auctions +[transition(selected="Diamond")]+> diamond_auction;

        gold_auction +[transition(selected="Main menu")]+> main_root;
        silver_auction +[transition(selected="Main menu")]+> main_root;
        diamond_auction +[transition(selected="Main menu")]+> main_root;
    
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
