if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

if [ ! -d "./logs/LongForecasting" ]; then
    mkdir ./logs/LongForecasting
fi
seq_len=104
model_name=PatchTST

root_path_name=../../../dataset/btc/
data_path_name=btc_short.csv
model_id_name=btc_pred
data_name=custom

random_seed=2021

# for pred_len in 24 36 48 60
for pred_len in 24
do
    python -u ../../run_longExp.py \
      --random_seed $random_seed \
      --is_training 1 \
      --root_path $root_path_name \
      --data_path $data_path_name \
      --model_id $model_id_name_$seq_len'_'$pred_len \
      --model $model_name \
      --data $data_name \
      --features M \
      --seq_len $seq_len \
      --pred_len $pred_len \
      --enc_in 5 \
      --dec_in 5 \
      --c_out 5 \
      --e_layers 3 \
      --n_heads 4 \
      --d_model 16 \
      --d_ff 128 \
      --dropout 0.3\
      --fc_dropout 0.3\
      --head_dropout 0\
      --patch_len 24\
      --stride 2\
      --des 'Exp' \
      --train_epochs 1\
      --lradj 'constant'\
      --itr 1 --batch_size 16 --learning_rate 0.0025 2>&1 | tee logs/LongForecasting/$model_name'_'$model_id_name'_'$seq_len'_'$pred_len.log 
    #   --itr 1 --batch_size 16 --learning_rate 0.0025 >logs/LongForecasting/$model_name'_'$model_id_name'_'$seq_len'_'$pred_len.log 
    # The below line prints out the log to the screen and also saves it to a file.
      
done