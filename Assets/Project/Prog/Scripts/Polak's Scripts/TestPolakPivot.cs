﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestPolakPivot : MonoBehaviour
{

    public Animator AnimPivot;
    [SerializeField] private Vector3 _position;

    private bool _hasBeenUsed = false;

    private void OnTriggerEnter(Collider collision)
    {
        
        if (_hasBeenUsed == false && collision.gameObject.tag == "MainCube")
        {
            _hasBeenUsed = true;
            Debug.Log("slt lé pote");

            collision.transform.GetComponent<Rigidbody>().velocity = new Vector3();

            collision.transform.parent = transform;
            collision.transform.localPosition = _position;
            StartCoroutine(DelayPivot(collision.transform));
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject.tag == "MainCube")
        {
            other.transform.parent = null;
            other.GetComponent<Rigidbody>().isKinematic = false;
            Debug.Log("fini");
            StopAllCoroutines();
            StartCoroutine(BackAnim());
        }
    }


    IEnumerator DelayPivot(Transform collider)
    {
        yield return new WaitForSeconds(0.3f);

        AnimPivot.SetTrigger("Pivot");
        /*yield return*/ StartCoroutine(StopParent(collider.transform));

    }

   IEnumerator StopParent(Transform collider)
    {
        yield return new WaitForSeconds(1);

        collider.parent = null;
        collider.GetComponent<Rigidbody>().isKinematic = false;
        Debug.Log("fini");
        StartCoroutine(BackAnim());
    }

    IEnumerator BackAnim()
    {
        yield return new WaitForSeconds(1);
        AnimPivot.SetTrigger("backAnim");
        _hasBeenUsed = false;
         
    }
    void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireCube(transform.position + _position, Vector3.one * 0.25f);
    }
}
