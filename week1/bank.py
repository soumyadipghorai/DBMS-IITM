# pseudo code 
def begin_transaction(creditAc, debitAc, amount) :
    temp = []
    success = 0 

    f_obj_ac1 = open('accounts.csv', 'r')
    f_reader1 = csv.DictReader(f_obj_ac1)

    f_obj_ac2 = open('accounts.csv', 'r')
    f_reader2 = csv.DictReader(f_obj_ac2)
    
    f_obj_ledger = open('Ledger.csv', 'r')
    f_writer = csv.DictReader(f_obj_ledger, fieldnames = col_name_ledger)
    
    try : 
        for sRec in f_reader1 : 
            if sRec['ac_Num'] == debitAc and int(sRec['balance']) > int(amount) : 
                for rRec in f_reader_2 : 
                    if rRec['ac_num'] == creditAc : 
                        sRec['balance'] = str(int(sRec['balance']) - int(amount))
                        temp.append(sRec)

                        f_writer.writerow({
                            'acc1' : sRec['ac_num'], 
                            'acc2' : rRec['ac_num'], 
                            'amount' : amount, 'D/C': 'D' 
                        })

                        sRec['balance'] = str(int(rRec['balance']) + int(amount))
                        temp.append(rRec)
                        success += 1 
                        break 
                    
            f_obj_ac1.seek(0)
            next(f_obj_ac1)
            for record in f_reader1 : 
                if reacord['ac_num'] != temp[0]['ac_num'] and record['ac_num'] != temp[1]['ac_num'] : 
                    temp.append(record)


    except : 
        print('wrong input') 

    f_obj_ac1.close()
    f_obj_ac2.close()
    f_obj_ledger.close()

    if success == 1 : 
        f_obj_ac = open('accounts.csv', 'w+', newline = '')
        f_writer = csv.DictWriter(f_obj_ac, fieldnames = col_name_ac)

        f.writer.writeheader()
        for data in temp : 
            f_writer.writerow(data) 

        f_obj_ac.close()
        print('success')
    else : 
        print('failed')