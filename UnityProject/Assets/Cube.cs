using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine.UI;
using UnityEngine;

#if UNITY_IOS || UNITY_TVOS
public class NativeAPI {
    [DllImport("__Internal")]
    public static extern void showHostMainWindow(string lastStringColor);
}
#endif

public class Cube : MonoBehaviour
{
    public Text buttonTitle;
    void Update()
    {
        transform.Rotate(0, Time.deltaTime*20, 0);
    }
    
    public void ChangeColor()
    {
        Color color = Color.white;
        string titleTxt = "";
        
        if (GetComponent<Renderer>().material.color.Equals(Color.white))
        {
            color = Color.red;
            titleTxt = "BLUE";
        } else if (GetComponent<Renderer>().material.color.Equals(Color.red))
        {
            color = Color.blue;
            titleTxt = "WHITE";
        } else if (GetComponent<Renderer>().material.color.Equals(Color.blue))
        {
            color = Color.white;
            titleTxt = "RED";
        }

        GetComponent<Renderer>().material.color = color;
        buttonTitle.text = titleTxt;
        
        #if UNITY_IOS && !UNITY_EDITOR
                NativeAPI.showHostMainWindow(titleTxt);
        #endif
    }
            
}

