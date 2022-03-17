package com.milifestyle.app.repository;

import android.app.Application;
import android.util.Log;

import androidx.lifecycle.MutableLiveData;

import com.google.gson.Gson;
import com.milifestyle.app.model.request.PostRequestModel;
import com.milifestyle.app.model.response.PostResponseModel;
import com.milifestyle.app.model.response.all.AllPost;
import com.milifestyle.app.network.RetrofitClient;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class AllPostRepository {


    private static final String TAG = "AllPostRepository";
    private ArrayList<AllPost> users = new ArrayList<>();
    private MutableLiveData<ArrayList<AllPost>> mutableLiveData = new MutableLiveData<>();
    private Application application;
    private Gson gson;

    public AllPostRepository(Application application) {
        this.application = application;
        gson = new Gson();
    }

    /***
     *
     */
    public MutableLiveData<ArrayList<AllPost>> hitPostApi(PostRequestModel requestModel){
        Log.d(TAG, "hitPostApi: RequestBody: " + gson.toJson(requestModel) );
        Call<PostResponseModel> call = RetrofitClient.apiInterface().allPost(requestModel);
        call.enqueue(new Callback<PostResponseModel>() {
            @Override
            public void onResponse(Call<PostResponseModel> call, Response<PostResponseModel> response) {
                Log.d(TAG, "hitPostApi onResponse: " + response.toString());
                if(response.isSuccessful()){
                    PostResponseModel responseModel = response.body();
                    Log.d(TAG, "hitPostApi onResponse: " + gson.toJson(response.body()));

                    if(responseModel != null && responseModel.getAllPostList() != null){
                        mutableLiveData.setValue((ArrayList<AllPost>) responseModel.getAllPostList());
                    }
                }
            }

            @Override
            public void onFailure(Call<PostResponseModel> call, Throwable t) {
                Log.d(TAG, "hitPostApi onFailure: " + t.toString());
            }
        });

        return mutableLiveData;
    }


}
